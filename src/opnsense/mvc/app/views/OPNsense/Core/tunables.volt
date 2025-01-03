{#
 # Copyright (c) 2025 Deciso B.V.
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without modification,
 # are permitted provided that the following conditions are met:
 #
 # 1. Redistributions of source code must retain the above copyright notice,
 #    this list of conditions and the following disclaimer.
 #
 # 2. Redistributions in binary form must reproduce the above copyright notice,
 #    this list of conditions and the following disclaimer in the documentation
 #    and/or other materials provided with the distribution.
 #
 # THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
 # INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 # AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 # AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 # OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 # SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 # INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 # CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 # ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 # POSSIBILITY OF SUCH DAMAGE.
 #}

<script>
    $( document ).ready(function() {
        $("#grid").UIBootgrid(
            {   search:'/api/core/tunables/search/',
                get:'/api/core/tunables/get/',
                set:'/api/core/tunables/set/',
                add:'/api/core/tunables/add/',
                del:'/api/core/tunables/del/',
                options: {
                    formatters: {
                        "tunable_type": function (column, row) {
                            let retval = "{{ lang._('environment')}}";
                            switch (row[column.id]) {
                                case 'w':
                                    retval = "{{ lang._('runtime')}}";
                                    break;
                                case 't':
                                    retval = "{{ lang._('boot-time')}}";
                                    break;
                                case 'y':
                                    retval = "{{ lang._('read-only')}}";
                                    break;
                            }
                            return retval;
                        }
                    }
                }
            }
        );
        $("#reconfigureAct").SimpleActionButton();
    });
</script>
<div class="tab-content content-box">
    <table id="grid" class="table table-condensed table-hover table-striped" data-editDialog="DialogTunable" data-editAlert="ChangeMessage">
        <thead>
            <tr>
                <th data-column-id="uuid" data-type="string" data-identifier="true" data-visible="false">{{ lang._('ID') }}</th>
                <th data-column-id="tunable" data-type="string">{{ lang._('Tunable') }}</th>
                <th data-column-id="type" data-type="string" data-formatter="tunable_type">{{ lang._('Type') }}</th>
                <th data-column-id="value" data-type="string">{{ lang._('Value') }}</th>
                <th data-column-id="default_value" data-type="string">{{ lang._('Default') }}</th>
                <th data-column-id="descr" data-type="string">{{ lang._('Description') }}</th>
                <th data-column-id="commands" data-width="7em" data-formatter="commands" data-sortable="false">{{ lang._('Commands') }}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
            <tr>
                <td></td>
                <td>
                    <button data-action="add" type="button" class="btn btn-xs btn-primary"><span class="fa fa-fw fa-plus"></span></button>
                    <button data-action="deleteSelected" type="button" class="btn btn-xs btn-default"><span class="fa fa-fw fa-trash-o"></span></button>
                </td>
            </tr>
        </tfoot>
    </table>
    <div class="col-md-12">
        <div id="ChangeMessage" class="alert alert-info" style="display: none" role="alert">
            {{ lang._('After changing settings, please remember to apply them with the button below') }}
        </div>
        <hr/>
        <button class="btn btn-primary" id="reconfigureAct"
                data-endpoint='/api/core/tunables/reconfigure'
                data-label="{{ lang._('Apply') }}"
                data-error-title="{{ lang._('Error reconfiguring Tunables') }}"
                type="button"
        ></button>
        <br/><br/>
    </div>
</div>


{{ partial("layout_partials/base_dialog",['fields':formDialogTunable,'id':'DialogTunable','label':lang._('Edit Tunable')])}}
