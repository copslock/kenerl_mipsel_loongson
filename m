Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 12:29:42 +0200 (CEST)
Received: from mail-bl2nam02on0088.outbound.protection.outlook.com ([104.47.38.88]:18528
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992127AbdF2K3eRvLdP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Jun 2017 12:29:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HtG77QKpoAwiCSZKLc4NJu6/0V7UuV4Wlcy9QhHfEDs=;
 b=E74F14ps0yT6n383q/lU9uE7F2weWeakuxKSj1WS4XyThsTZBdQwqViYHgZH3zCDJfoYrXQq/gmqbmc1tukBdh7xaa/+6X7sZiqQ/TjWfVM8bgwnyIFmwr6uvyqTcxXeIR/zOBhHoL5uZRJcIgHUxBoe8vZll2+0eGXG1kmVtpI=
Received: from CY4PR02CA0023.namprd02.prod.outlook.com (2603:10b6:903:18::33)
 by BL2PR02MB337.namprd02.prod.outlook.com (2a01:111:e400:c25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1199.15; Thu, 29
 Jun 2017 10:29:26 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR02CA0023.outlook.office365.com
 (2603:10b6:903:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1220.11 via
 Frontend Transport; Thu, 29 Jun 2017 10:29:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1199.9
 via Frontend Transport; Thu, 29 Jun 2017 10:29:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1dQWhQ-0007dE-Ar; Thu, 29 Jun 2017 03:29:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1dQWhQ-0002uO-6P; Thu, 29 Jun 2017 03:29:24 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id v5TATL3I005492;
        Thu, 29 Jun 2017 03:29:21 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1dQWhN-0002st-3W; Thu, 29 Jun 2017 03:29:21 -0700
Subject: Re: [PATCH] EDAC: Get rid of mci->mod_ver
To:     Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>
CC:     Thor Thayer <thor.thayer@linux.intel.com>, Mark Gross
        <mark.gross@intel.com>, Robert Richter <rric@kernel.org>, Tim Small
        <tim@buttersideup.com>, Ranganathan Desikan <ravi@jetztechnologies.com>,
        Arvind R. <arvino55@gmail.com>, Jason Baron <jbaron@akamai.com>, Tony Luck
        <tony.luck@intel.com>, Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Ralf Baechle
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>, Loc Ho
        <lho@apm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mips@linux-mips.org>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <36769669-866d-8bb1-a9ac-399ed56066bf@xilinx.com>
Date:   Thu, 29 Jun 2017 12:29:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.1.0.1062-23164.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(39450400003)(39860400002)(39840400002)(39400400002)(39850400002)(39410400002)(2980300002)(438002)(199003)(189002)(24454002)(9170700003)(9786002)(23676002)(36756003)(50466002)(54356999)(76176999)(50986999)(31686004)(33646002)(106466001)(63266004)(189998001)(36386004)(53546010)(4326008)(5660300001)(305945005)(478600001)(4001350100001)(83506001)(65956001)(65806001)(81166006)(229853002)(8676002)(31696002)(7416002)(47776003)(8936002)(6666003)(2950100002)(6246003)(38730400002)(2906002)(39060400002)(54906002)(2870700001)(86362001)(65826007)(356003)(64126003)(77096006)(26583001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB337;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;MLV:ovrnspm;A:1;MX:1;PTR:unknown-60-83.xilinx.com;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT027;1:3nmCKq3K33OP8JGYraXwEQs0rNclFxERsDcGqio8YLVIXPM1xDxAnrc4S4oLV00+eE6iG9FMOcgKe8ZDWGAoPFhZkdG1CXU/EQ/8rW4CGL6D7/Vyot85GQCIKjGApw9qOc61+yNJMlV6jLCAOX3yFzKaCANLZR+W4u6K+wB9Uaagcp8M35LPsoYoDFSOxz/6erj1U0QW56FVB/A4LtPQ2LBs90XECXx2tkwD5xDJou6xrfgm6OfAB74LKK1awcPE4HxVEKaRVAMcNKmdHvigplzBPZXcCjHG/UNaIxGj4KiCSV9TKcbjLVa916pXg/3TDltLJFKTXJ2fB9CIXCO6mhWj8zUguJQwK/M98Vov9HRpt9SoFoTQ/MxrEfR33AqWyG/XxOSdMcZ9txU3/l21DMFiNXtHNt/9zV1QnaPuw4WE2KLkSJ8XlpfNI5EyKH5CXerimbSCcy8yHBGAU4e81pLqnPHlJfwHhgWGH2dl4dap/TlxvlHBGO2Wx+MxL5ONisQsYORDgYthDILGcG//BMqfqrarRYVchjp3qzAox7en7LGxX2M0twIUSOhUY4O6y9gASG9vPQLDmKoUlpoWZCj3QiHHyzBlhPTOaMPkxNSa0jiYf2pd/6CFN8vQJyDibXis8NbnZ1xNh8hY87/saLNSjNv1x6QfSeeMUO13pT9q0lBBn4pWy5UZxlaT4yPlrVqavGhCR9aHU5hhUQbR6lcQOAdOhPtbdYx2thv5ANUP3n5BOQtZK6VeCOajsVIwJncYiJNFry7YSO79FbfDsTBqNER+d9BjZirJMl0L9pRGlN8wHhRSt7MH8KDVTSMqcEOqQwA6sL03Yz96kGle5rsCIUmVlBzlx0xPysMmN+kwv/3oREI8Hcv5TN3sFhB61LZvAP2m6B824n3CagJ5pk8H4ApcNNpqgQmbv0319R0=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e226b93c-98fd-4eca-cbe6-08d4bed9b752
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(8251501002)(2017030254075)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BL2PR02MB337;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB337;3:/AL5FDyMvWMfOZx6WPXYfpOciLlbVSK+mBtgjHkPwuBgkLst35N41LcpTyx7J5NrU17OF6CmoTVuEjYAXYkUNFRa3LMheeYUjp66fkHB6//ZlCsjat8QLF6APhU3hFr1SAsOpg8r+Jp3YMjiMsmfqJgfp6vCdIBjqQzVvBZuHnPgM8Lsk84HzhQ88dQ8SK0VIt+mcptnuU/ZirfSh8k1YGfMmfcVJNhOCIuHzdsgt/4H3+oaei17CldDab6wt89J2GJJI5VcYI5BgukmeQ6BhIsEcgmNrYUKEKhGLve7lhPlkSF4ABE/aVnSixX9v8D3MW3PTrUkeOvezhbThvk08Dz48llrz+BDoQ03K3lL8cIBT++J5FwNTelgIbb1OSk1ZBlAgv2Af+Mx7JskvJDHLPssBYAXhuHZr8VC98RwzjjhyXJkMK62fVNNb4fr2xVecnEukRD90VtZZ0fuIcqUsGo3s+8hnxnBIKYKRj7eQKEz5xXv9t37JfgiYi2oDFt5mAtNCeqx2SWVQLwZYgTAPQrCuEbH+P2Nz7a2gfpkmG04xc2ASIJo/QELj54KHczUcQk6wPOw3wSobmqwJpuM1KWAl9YKtV+BReppdxqXAnYNM1luikYINsXd7jiL1cL+GP6T0zVWt7heb1YDzVQBT8paY7s12SkFFifQ8hOfTXe5wesa0r/DxPkdMefjBkCb3EqQHkl1dhjKtKAahjqGuxelwYwEq+15BMBf9kQtAQ9L1XN/ydhAZ0JPmKA5Og+1G6bc4wC+QDtT8gb/91y5P5FX9DPMxN5jRsLjD5IOzZa481k1k63SvzvLbvvchND2YZoVeNbMAXYugxA687gpxTzARJxKuEGJbYv13FK1gIJFm/5kzHxubPbQjlXYAnn+Q3Pup4ifNT6SI3sU/BDynZPL3pEK+kBpFiKfg5zJrUQ=
X-MS-TrafficTypeDiagnostic: BL2PR02MB337:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB337;25:g7qnVmh1YkmfQVDQtU1WHpir0PzPY9iV3Y0oJVA5iQFV2AQiQmPq/UgX+/+a2h/ZWMbCEpBUOEjJWDtQDb322KQz6mbxk0nJgDOItgdEn33+pVTqyeYEXU5mVZtURh674zpL4f4xJkNZkYoPtWLIW7vPcNo03J3WF/ckPkiZNsDNTr3tO0NnCQFQ7vn+AXfHIJeOKInBJKWgFG+QOMcWUWMSaMOryroqlDvB0tooOAsXVbi1w6zZPfd1De8olhCfJw8wz1szGDdZHCHeVM4JQdOIitircc/dJOMq52onGcFHE2kQjt07bf3sbapHHXUwQqPEEWrW3+nSWdLfpiNZJcqHVhgMg+DGmWzzPatpUn7hStBD8+gQCqX5yy4jkg3+1S18dd7EWdT/3rNTAmsVBlpTw0c/0J077EOgBfUpKjnKmBrvEySnCQfIrtWWqLKevGj4ZjJ5RC5qr4dB9cqSE7/8W9/nnSJpGmh4fEtWoBrTO6T13O1aO5nKsFZtsxtWQbnBlf+pPBNQqJDskfYTlVFLFoPhjWBgVA3PyO8mLK38o9y5LIMPyMQTAo7rOR69zhGEuTr0/EIGYnHZsxarJGDmxWB/F82FlBRxP+m0Mg9cYqs1GWNeHVAT9FTd6npl+Qj1ZDhD5QCkif+yRS6mPDF8LmZ2PiDlqvFvz821pYlfGlpyMAFp6CKTFjYBpaEg8Y7zSGK+JBM+UbNnHeECfrKH8XUaroiOmcX8duPS2j3wKXtIMWSeUH14Qu59sFHi/6XoPx4036ro5W8zSN42UmjM0zOolR1YThlXDStGf1k58ovTfhMbCeUtOkCxsrAtqFLqaUy1FB92OWH2dxkClPG93YdiIEYZ0WZ4jQy+zO10E8kDLVrsZbS9/pHql6BTGGoqG6Ak5pyYgU288lCLVXsB4ZmO9BHGX73fBSVbEIw=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB337;31:TFrG7j6SWmKyzy/ZDJNdaSBjfCVAJdXD3joQ+wlYkcB7eblbhujxgT9S8t3ucqCroX3RCrFSYhLfE/VzYhJccyY0UjiG8hdEr0xASWWy6UDPHU1qpS/WiuzFh3zSrSTUOuOTVUOV+91MFKUFrNoQaRwpp6ypi5VWMiihTpz1wCe4w6cSnGrGy1DPCxEFa/KDiH2Egi1rgUlGOdhZH9OVQPMq2Bj3cskgl8/4HoY56Qph8sFeFOHwy+7xOR9oyqSJzXt/T5ceDy5WfRLHPh0LwLx1DS7bYZH+A49n7BIzjy08mC7f0oLpRZNXcE9LrxMAo6PuW17qpOX+DRw6fWl5RA4EaODBz+Bsdcuym3ONlwnFZCjwndEpm3Zq2cwPxp5n5gIin6Ji/m4Sqsa4bgdbPsoCVwrYD8lpL6jgSSgBF35//JFQ5DC3I4T202f9e1rphfCyyXDBEsk7UWKUhVo//3a5dMQ8nRGgqYtQr3sVdgs3SyS4WbixbBohzv/kq+8cJVVOBkbnbUN0YSDNLOKRsy34aWGW/XBkUWwc3vbc/HYBFz75K8Jh0iLgBIYRemdu4EhVduZOSDO9NaSvTm2B6CY5Yd8SeVyLIqZTuWsdW4W2gAPVbnYkEssQRrtalRMCgnWOH0bCMoimGaqh1zO5nX7qHM9s9mCIYHkXtYZBhBxqWN8MZ+eT+PCLum285S4PLQ91Of7xwHiOy1NkcyPrOQ==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB337;20:JbIGeXWg8mx/tBPBMGWVkXBu0BQ4hCy0lXXOmyxBUSqyh1+8km7E7+IxawFOFRcZQZtn/Cpay/v75gDRczw5MP5Igrix+lqPVMWncWAGy8sYQ8vWoz3liWoKEoKogS3cZ1ssR8gTPY+ZoCt9KqzEWpjmJUHiY8rheNLSG5wN4Ln8O/n15IiJCTvWxHn32ZL00BKbGdIBlONLIg2rGgHUN2KaEnRigDj66qyHTZyUmragx3wxULhHPDmXXO9FkoHrORwBxthpc50+jMkqu/z+2hivwImX7ThPn2CyH58Hlog3wuCjb48Hp71OAnpxr93cZHZvsO0KrHoWpo5jhDsn1AHsCSw4uRlD9eqQxIbn0xtM5Hlqpo2Zhrc8sqxO2j9MrsDXygQyUwJXJwu9F26AxDaW5rFpa4vQa74cMfo0g98egwpBljDDuQxjtqf+CZGZ2+MzSQaSY5wnkvg583PLwvIpKrjdMnSWaMe100D9tWp53dggsJmVDu8UQWqhueFZ
X-Microsoft-Antispam-PRVS: <BL2PR02MB337CDBDBE95F2C9F31336FEE2D20@BL2PR02MB337.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(258649278758335)(192813158149592)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(13018025)(13016025)(5005006)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93004095)(6055026)(6041248)(20161123555025)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BL2PR02MB337;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BL2PR02MB337;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAyTUIzMzc7NDpkbEV0SEtrRk9aVE51VXJhOFRxR1d1OUgxT3Vl?=
 =?utf-8?B?M2l6M2pxV3dweGg3bm44SGx6VlQyL1NTNDZCOW53eHZpcUltSDFFZ21nNTFw?=
 =?utf-8?B?bkhxTFhtd1NHdUQ5QmVIZThSK3pRRjUxTTNtbXluRXJRV0oxZ0N6UHRJby96?=
 =?utf-8?B?dnh0bkVNMitrMDZJOURrcExTbkhiVmtmaGJCd1lwY2FmSTY5dkpHRnlvbUdK?=
 =?utf-8?B?MmsyeHVnSFFtd3ZPaFRlK3FlTkQzYmNCN2hvUWY2dzBHUDUyQ2JkZXFDQ1BB?=
 =?utf-8?B?d0tDY2ZvalB6bnZFaTBKQnV6SU5mMGlwaXFoek5PMTdsb21OUkgzdGNQcVJh?=
 =?utf-8?B?TFFKK1lKNDJKQk1mcFpvVk91SUhlRHNWVlNzSkVnNXA3WU92M20wWG9TSU1Y?=
 =?utf-8?B?MDMvbThVMDZSVk91VGIrNmxrVzhRbVFmTzlhTTM3NEkyVFpMVlZQdTJVaXFp?=
 =?utf-8?B?VWFHazNqdWEyQWhUeUZlSHp1MjJHUmJMWVR4a2RnMGpZRzYrQlFDai91VmhC?=
 =?utf-8?B?OTY5aHBXYyt3WjYreHUyMFV6WlFGam9HTkxENXhCdzZWUnZ1T293QXJ1WlNn?=
 =?utf-8?B?czZsaGl2ZFkwazg1VFNGL0U1MW9Fa1lCTnlaN2RFVmo1eE4xS0NvWHRnSHhi?=
 =?utf-8?B?eUgyS1VkQ1FxZFN5NlZXWWlBeXY1UUIwY29ML3V2dFc1U1ExS1d3RjhSL1Ru?=
 =?utf-8?B?UGUzSXh6QmVCYUVScEwxaUVTWmRLbDNpSkdnR3Jlb09SUnk0blBub1dGVU4z?=
 =?utf-8?B?QkQzT0JmZmRpcmh2STZuUHQzaHYrbEdOd1VyWUhnS0hmaXFSOVhMRTI0RXFY?=
 =?utf-8?B?aFRHdSs5Sk15czBrNG4rc2x5Yk1IbUs5Vnp3ZVMreUUrVFNqRWVzNCtlQVhy?=
 =?utf-8?B?RS9MRHRxYzFjdmU0ZkZ6NDduSW5lanBNMGtiOXdxTUxjZnBUQXM3eEd2MWhz?=
 =?utf-8?B?YmhpTmd5S215eUhDM01hZWRxbktJRS9qWi9RZ1FaUTB1YVRJekJRbW0wQ1pF?=
 =?utf-8?B?cFNTNFlpMVhJOTh5TnpJd0pvRzExYzJtTE9CMEYyeENxcjV4UjJpWXd5ZFNQ?=
 =?utf-8?B?NE1RK1R6ZjIwSmIzVTg1Vnc2MlJJOThCSkwyTzNncU0yWW9LVlNNVzNVSHZD?=
 =?utf-8?B?aktEdDkxMmhlaGthYmVYdFhnbi8vTWtPVCtSOXlBQ2tTOVNybHdHUHFKaXc2?=
 =?utf-8?B?cTY4bDk3eUNnR2tlK2VHTkNuS3RtVG55cHZuc09qbzR2TDM3Z3R2ZVd4bCta?=
 =?utf-8?B?UHdaWW9ETy9zREdBRUQxSjNMN2RueEJqZlBLSmhLY2pwZWNRMyttdG9UVUtp?=
 =?utf-8?B?b0g3eDNhQ2l0ei9SRk5oTmpyczdGTE1RNzNUZE96aWR1MFIrRy9ydUJqTTRW?=
 =?utf-8?B?dzZFWFlLMmZCV2Q4TnJUQ2JaZFViZWw4MUR6TkFkOHVEdHoyVlc0WjAwMDha?=
 =?utf-8?B?K2NkTGpBQ1AzZjF0blZOUHRrSGpUd2hMTERWQit6L0dPYjdlV0NrNXBDRHUx?=
 =?utf-8?B?RnpQWFdGMzlZT293Q3k2dzl1QnV3anZYYzVaK0Iwbm5jeUp4U2NjYnBrd2FG?=
 =?utf-8?B?MGZ2YnlZYmMydjdSVjhzaWc5T3pmMU9ZNjNjZ3V1Ym9ITFk1ejZveVdhNmVj?=
 =?utf-8?B?NTJuVjVYVmFsNk43QkgvUW9SdFNKSFlFb1FGTG1lSEJwaytOV0t5czJzZzU4?=
 =?utf-8?B?ZEZ0bWt4RjJQQVVSWS9PM2RkZTF2SGc4QzhkYnJSN3AzZjlXQk5VcStQc1Q0?=
 =?utf-8?B?RmszK3UwMFhQWlk2Z0VKaXJPSmEvR3ZVcVczeW1HU2h4T2I1SnpWbU8va1Bj?=
 =?utf-8?B?bXUveXh3S2d2RUhDU05YQ3crbjJJR2pXWVkyWGJpL0tRPT0=?=
X-Forefront-PRVS: 0353563E2B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAyTUIzMzc7MjM6N21nT0JFNEhrQTVIQjA4Smk4QlJ3SWdnWlBw?=
 =?utf-8?B?Q0NSYUJhOVp2WGZ6SzdSRFJCZmpMazdydmU4b09xWncwRmk0NytHeDFIZ2Yv?=
 =?utf-8?B?OFZDZ0lPbU8wSDh5LzUybDREWU9pdFI1TGthUXp1ck9vVS9RaDNrRjhqSnRP?=
 =?utf-8?B?dFIvTWtWNFJmTy94dWRDcHpnZWE3L1lTNEJCaHVHK0IvWklwMStWY0VLNkxT?=
 =?utf-8?B?YlRkM2NEcVZ0US9vTGRjaTdoUmdzWkRxLytUYktkYTNldXA5SVRkemlBTzU3?=
 =?utf-8?B?bGQ5S1FmM2FqVkhPWkNraS9GTHhMd3B1Wk9SSlRlY1RJVDAyeEhsNjM4Um9q?=
 =?utf-8?B?dXlwYmk0d2RtR0dwTWVOZzRvNzZxM0FjamN2QVZTQ0RBYmhZZ0VndFY0MFg2?=
 =?utf-8?B?SURhWWM3ZnBzSUF5amhYeWNsaGhVOWtmWWlpMUhMVlgzTFdFUXR5b0ZZUjZQ?=
 =?utf-8?B?V0wyb2FuY05OYlBIKzhVaExIS2Y3TzE5N3pJRVkzWnlBQ1dVQVhZbEVXUTln?=
 =?utf-8?B?aldlM09YZkc1bk5ldnllMzNwZ0NKZ0VvUHdLb2lWbFBMMUtPZEt3cURDclJW?=
 =?utf-8?B?R040WDlkK08vNkNMeHg5U0tlR1B0TWo1OUVkU20yNk9pL3k2M0NQYllWODNL?=
 =?utf-8?B?MDZKbHJmUnBNYXNmakNNNnFyVEZaampBYk8yeldBNmlLYm5rZ3QzdDBHaE5t?=
 =?utf-8?B?ZFV2Skp1N0hLL3hNSVZEK0lwYk5HMVFSV2xiajJLYmRWR3E3NklaRzJ1RjhK?=
 =?utf-8?B?NU5xQ3BHK1VWRUpLY3loMVA0aWNYNytQK09OVVdiRFBSd3FVOWdVMXVLTGJQ?=
 =?utf-8?B?WkZPOEN6MFpDZFdFQlBrNHNEeFNWOWFxU3ZDTU1XbTlQcWV2NlR2WjBITSsv?=
 =?utf-8?B?bHQ2UTJFL0tCc2psWm4vSDhzUXdaY2cycHRkekFvQjNmRE1Sdnk4Z1RQRUNr?=
 =?utf-8?B?Q0IxeDlHQTYvcms2YlFicTcxWHByRnJJSzVKRkRtSUU5b0dOWXp3c2ZBdG40?=
 =?utf-8?B?eFBBN3YzK1J6WmpQdmU1Ni84Tk9MbVJXekxKUlgrWThCOVhqNUJ4QTlQZ0tC?=
 =?utf-8?B?T3RSQkdQWHVrV3FaL3ZxS01QdWhkSis3WVV1OSsrOEYvNTVhRWFjeVl3OTND?=
 =?utf-8?B?VEJWaWFaZ3puQ25naWU0ZlVpKzlhR0pNN2hkazArd1gyZzVwdUVUYUVoMXlE?=
 =?utf-8?B?Nm04YnN3UGIrU2lsVDJrY3hIWjN2ZFEzYUpWWWUrci9ybzZ3Q0tRRTNwSHZH?=
 =?utf-8?B?dTRLZ3F3T0IwUlpvQnV2SU9pUjA2aEFWTjE4b2M2K3EzWThOY09uOU1rblhG?=
 =?utf-8?B?R0RFUHZEL05Nb2FmUGVnSjQrSWQ0OGNobVF4K1hYNmR2QUo5Ty9IMktKWjds?=
 =?utf-8?B?a1diV1Y3YVFZekZicHphQzZSMzJGLy9LTUtvZVVHTnE0S0tZUWFRMDM2d2Zk?=
 =?utf-8?B?M0JybFN4YTA1eW52WHFSMHM4Q28wSUNKanZadWRIZ1BZSHhreFBBN0tDSVVB?=
 =?utf-8?B?Z2s3NkxOblYxdkJ5RWZKRExUV3NFOVlaMTM1N0JDSlZPNCtOQlBNVHVLVHpn?=
 =?utf-8?B?S3lld3BOcFQyRzlzc2NFcHRRaXRmZHYxRmwxMkg0cXd2T3pBM3d2a1VxMElB?=
 =?utf-8?B?YUgvK1JTTjE2WDBUMzJtaVEva2ZiZ3VJVlg2c21rUDNkN2tNTS9SOXRGVHBR?=
 =?utf-8?B?clI3RHJ0K1JrYW5CSWxPTnE3QmxJYlhaRW9UQnZoQUQyb2g1akV4RU1BU1JT?=
 =?utf-8?B?STBsTFBhRERYWmlQOTgvZnZ4UDI1TU9BYmdaMEhJZWZ0T0krcndCbHE5N3Uv?=
 =?utf-8?B?MElvcW0vVXIyeE1rZHdid0VySS9qcXhWbU94WEVyckxEbnNPZ2dEVzhKN1hZ?=
 =?utf-8?Q?myGaxO3Lop14IupOoWKO5RUGPWV88ic?=
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAyTUIzMzc7NjpzQ3lGMTc1Z1NNTVlKMElpZUtxR2VBKzZ3WTVq?=
 =?utf-8?B?T1BSSStuSnozQkZzS3hXSXJTaHR2QWcrZERZMHIrb3JWZW8zdVE5WEFrWGxa?=
 =?utf-8?B?QnNBWFljUnI0cXNpM3RzU2w5Tnp6WjZHMnorR0wvTFVoR3BzRUVoOW9FVzhE?=
 =?utf-8?B?NnorM2hPdXk5OVRaeVBYQStJaGFMbTF1VHY2SjEwWGd6V3UrNDl4UU9UWmJm?=
 =?utf-8?B?THc1SnRiWm5xempaK2FnNFd5LzJZTy9tbFZzYlY4ejNQMHE5M1dreW5RNXNy?=
 =?utf-8?B?clpsNzRGWHFZa0VHMkRGZERWRzVPZW1RYkQzbE9JQkR6bGtDU3RsbDBYRFZ6?=
 =?utf-8?B?VW1GbmNweWRTcEZRbHpGN1RkcE54MXNOMmpqb3k5TEtvMU5hTHA2dnZ1L2RG?=
 =?utf-8?B?dzdmY2Q1WmZzSEVzUXNScTJ2RWVQN1Z6RkE4bkZTb2M3TGZRbjlZZ3FRWjFC?=
 =?utf-8?B?UC9RL0QzQSthdzBZVmlLRjBZSStvYUpFd1lZVjA5Z1E3SGdNOTA1eVZCakxk?=
 =?utf-8?B?TVFlajZwNHp2YXhVNHpnVDk3N09hYjExVFVLek9WK2FuK2ZxZ0Zoc3lleE1o?=
 =?utf-8?B?NkgyUjlwUzFLcEZvQUJEUTdPczFlLzdDeDJaQzlsRGFkWG16bXZNMC9zZlJZ?=
 =?utf-8?B?aUswWWcwK0Y1ZDlyaDZ0M3UyZ1dZWnNtVDVJaXVDNE1ZbzdIV1JubmIvaWFi?=
 =?utf-8?B?UkxKTzFYeC9iV1F1endQWGVLUmliT2lrem9lSkY3Q011L29ETDNHRmlTUE9x?=
 =?utf-8?B?TUdJTzZqMlM3TEVOMzBSUW5yYmUxWm8wWnN6UzVDTDVaMDRRMUxoNkZDTmNy?=
 =?utf-8?B?SW5Qc1I5UEV3a0NkUitqNUt6dmZYK1VkT3hJWHB2L1ozaFdhcEUrOU5HQ2Jn?=
 =?utf-8?B?aDY4WlNVVUd6dEcvTTFNR0JrU3RBNTNRdDcrc3dvT0p6MEhTZ0tUM2VTSVlU?=
 =?utf-8?B?WG02cGVCYjNrME1QNllVd3kwcno2SzgrMVlhTXEzUWpqdWhnblJRSVFpZ2M2?=
 =?utf-8?B?TUZsOHBvMXdvcHZhUXlvNnowM2ZGZll0TzI1QlNqUFFjNjlqVW5kNDRMa3p1?=
 =?utf-8?B?bUFlbFNwS1JiK3dRQmxJMFVDTmJJQnd2ejVIQ2JYYWVyTmdqUU01QVB2UmJW?=
 =?utf-8?B?RXFPT3Q1aWFxRmVWUlZnMUZXaU5IdnFOVmo5U09sak9UTEZEdzBEWGI3Y1o2?=
 =?utf-8?B?NGxmV0d6YThEYWRxTDZ0Nm5NQkNRbVZQanVLNkJ1VzI1dXZCWmxHTGlyZkcx?=
 =?utf-8?B?K3Z4dFpUYzRNK2laVXZVOG82U1lhZW5kZU82RlNtQ2NHUE5ZWWU0Z2J5V3dG?=
 =?utf-8?B?VmF3ay9MRkUzTy9UaDBick1hN0ZaS1RXTHdFVk5KWmtmVDVkWExlakJkWHZz?=
 =?utf-8?Q?hEmdlM?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB337;5:Am9fRJlDL2zM9pmFCxZYpkideTD82DCQf0OdhCCHGMMD0cwskiKi1khk03kEgQVRkHgVQw/PXSjxJoW9cLEwvy5z8AvTN54RH6cz+82HEv6EZh8pSRuyal4AFDqTaKEi2a1QOV9qEQIrpsTmabbiqhmtAKRkdY0g9SwbK/Ie4G0slxbJYdlAzlWVNDFYChcVSm/rGPS2B9azSEG0o2DV45ULRqGEGxd1y8h0+dVawJNPQ88Dw7y6NT60yWa86vi9iotPEhgQaNrTNPQ8/5AW4aGA2rTNDRDG9egvg1qCpRggFu3ya3cdFrwzUBWAGQlgUwvJkj28tjyRn1uNmNdVUKEGZ3ho4Phl96TCIG7w/Jcve0U62CFJVp8ItUzNSHLK/waBCsbSRrNm0neIixFcEGfF0KF3QkgOihJvf2jqVcFKFWXTXem5yq79q4mScVgQyzFU8OHay9ihcMYbXVa23yCTJ3x2GJUVY000TnYG5ZlUjub1ziGa8WGPXbs0k3sF;24:ZP+0mgpI3tmMjxtxI+lhOc0at3zFalHwMf9bfN0FCSNEw/GHcl0K1Eohli13eKerRQTleY3uSkbWxL7IZQECz5o98WZviwLm8qN28qgqdos=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB337;7:bBxZ3pubKGSl5Qj6j90NzWwNcrHT2Gvtjcdsdo0HtjEVMyYqIvexk0yr5zihGYYoe38OEqhLxNhPX9UlvyBXOb/tXXvThX7aEE2vH4TNG2pTvK9psggCUPx6u3SzXVcvt0SKeOA2tr/JyQ93yAGu6Jb1LMiAjK1IAi1F4tiTiLLUkPypQ6GUEWMBng/DV6m872DHVq0ZQ07Zat8yiDI5Ayi7yEcOB0W6Jqkjd0i/GHr1gP2H/NwUkVy6qIW/8ZkYYDo/YnnUzEec0AKG3JkSmmF4jNmbRW0t6Ph44MXgw5BrxPyFp1EdYWfWiQnGUTwFeVDJtjMN7sdOmu6CCKPPrqdLF7m59aMgdJa2/9WQOJpvpLrU6pU7FVcYFHxIEgvnJYP8AF0RBbN40+biAjnsTgj7ecQreqaotdMUeoC+DeRnk+xac+moHqgObmkYoTKrG8nIdH9Cp5WTBZHgi/+3oYtqT38OsUrtTquNd1Pnxn4aj0PM3MnNVrfDEBeZR44q8hj3LjeR5rxAJ1ZwgRylU9xuruKQktMuKZmX0kBtaH18RNfcC4xhxmroBwYJYlrDPux4EMsCCj89n91r0PjTnYulARNtUYo2hQWQfG1IkKQ/IMxQ8z8n8fYMkqL7xhFXFdnDwbb670D1va+ZiS1LwB1zJn+KyMeolOGUkHNMmxrULW5K7DgU3G/hXunJ02w/O/pbinaKCYkG+7pzNi6U8723N8fYueDFVAc8ABT8Pt+OL2Bjqj9sYlYevI/ST+e4GT6YnJC2hRr2uGH5P8MyAp2JuIiz5UDABn4oI3esMEc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2017 10:29:25.2826
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB337
Return-Path: <michal.simek@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 29.6.2017 12:03, Borislav Petkov wrote:
> Hi,
> 
> any objections?
> 
> ---
> It is a write-only variable so get rid of it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Mark Gross <mark.gross@intel.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Tim Small <tim@buttersideup.com>
> Cc: Ranganathan Desikan <ravi@jetztechnologies.com>
> Cc: "Arvind R." <arvino55@gmail.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Loc Ho <lho@apm.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/edac/altera_edac.c      | 2 --
>  drivers/edac/amd64_edac.c       | 1 -
>  drivers/edac/amd76x_edac.c      | 2 --
>  drivers/edac/cpc925_edac.c      | 1 -
>  drivers/edac/e752x_edac.c       | 2 --
>  drivers/edac/e7xxx_edac.c       | 2 --
>  drivers/edac/ghes_edac.c        | 3 ---
>  drivers/edac/highbank_mc_edac.c | 1 -
>  drivers/edac/i3000_edac.c       | 3 ---
>  drivers/edac/i3200_edac.c       | 3 ---
>  drivers/edac/i5000_edac.c       | 1 -
>  drivers/edac/i5100_edac.c       | 1 -
>  drivers/edac/i5400_edac.c       | 1 -
>  drivers/edac/i7300_edac.c       | 1 -
>  drivers/edac/i7core_edac.c      | 1 -
>  drivers/edac/i82443bxgx_edac.c  | 3 ---
>  drivers/edac/i82860_edac.c      | 2 --
>  drivers/edac/i82875p_edac.c     | 2 --
>  drivers/edac/i82975x_edac.c     | 2 --
>  drivers/edac/ie31200_edac.c     | 2 --
>  drivers/edac/mv64x60_edac.c     | 1 -
>  drivers/edac/ppc4xx_edac.c      | 1 -
>  drivers/edac/r82600_edac.c      | 2 --
>  drivers/edac/sb_edac.c          | 1 -
>  drivers/edac/skx_edac.c         | 3 ---
>  drivers/edac/synopsys_edac.c    | 1 -

No problem with this change.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
