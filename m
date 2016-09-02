Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:07:05 +0200 (CEST)
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com ([104.47.41.44]:36992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991344AbcIBMG4ezFMB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 14:06:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6BDmVsrf3Skx/0KQiMqM5T5i2gnij9MABR+lAEeM8Ic=;
 b=QaqNKVCwUzmLqfl6J5Yw4i9kya52I9e54tDe+2XXv5n5vfL73r3onsdgazTqLeb8ypdP3gj6TWy3Fyz27gCf0hMxZgYPCvzOS5yWQrzRNuIr2MQwT7k92lkzi4CJQXovQ4UyyvBRm9AvT59cc6Pmx/vciZN5CBC3nXTy1bIJwrs=
Received: from DM5PR02CA0071.namprd02.prod.outlook.com (10.168.192.33) by
 BLUPR0201MB1489.namprd02.prod.outlook.com (10.163.119.155) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.609.9; Fri, 2 Sep 2016 12:06:49 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by DM5PR02CA0071.outlook.office365.com
 (2603:10b6:3:39::33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.587.9 via Frontend
 Transport; Fri, 2 Sep 2016 12:06:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 12:06:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfnF7-0002S3-8x; Fri, 02 Sep 2016 05:06:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfnF9-0007Ql-AL; Fri, 02 Sep 2016 05:06:47 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u82C6hQP019529;
        Fri, 2 Sep 2016 05:06:44 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfnF5-0007PV-M2; Fri, 02 Sep 2016 05:06:43 -0700
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Michal Simek <michal.simek@xilinx.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <772f883f-79fe-9197-f27c-3ffe91019aaf@xilinx.com>
 <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
 <4931182d-7b30-582f-f291-5be59b6b89e4@xilinx.com>
 <03e1ee8a-3053-8823-751d-7513b0e316dc@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6c47c2fd-016e-fe88-ddcb-43d42ed5dbb1@xilinx.com>
Date:   Fri, 2 Sep 2016 14:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <03e1ee8a-3053-8823-751d-7513b0e316dc@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22550.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(377454003)(189002)(24454002)(51914003)(81156014)(81166006)(65826007)(626004)(5660300001)(189998001)(23746002)(586003)(2950100001)(8936002)(92566002)(356003)(2906002)(5001770100001)(50466002)(305945005)(77096005)(4001350100001)(4326007)(8676002)(11100500001)(64126003)(31696002)(7846002)(93886004)(9786002)(19580405001)(19580395003)(50986999)(36386004)(87936001)(106466001)(54356999)(76176999)(31686004)(2201001)(83506001)(33646002)(36756003)(230700001)(65956001)(65806001)(63266004)(86362001)(47776003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1489;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT037;1:Xuh+35m4mTKvAVtsKuYkSCWudPV0mI90Par+KUd5ZwAySimF1uUtVcUT2l7iImrEdqR3tAmPs+qCQjCi0N9qUSrw91TTnyuPd0x/teRX5UvQHMov8UCIwX9carem52XnNxhbNUGK5h5cJXgOIvckLBakcRCWt8TJFvpqOopcFLVGjF41sYfu+LNlFCG6Mf49iPMVXl+njZJOZaCSwwV3ojuhwTQBqPFfbYMOOd1kfuvGC4BRMBAQv5++GHAvvzEylSil7BpjNJGx2UbY2z+D1muXWWznOzYz7YnojMmMw6c+uNPbeYrZd1QXj8UeAtQtaFl5g9JdfKAKDJmi/lNKgOXRHvCOzd2dXIkjQRPw5vw3tADpyJwuQuXp5BHvyY7aZBVOc+6YxtSHOpRCk9GAj804Dt/eefinV6zdSRjQvACs2BRX+x9oL0RYBsYBe28jbINEFbFHNCJtMbDFMc3doy2NbKkxhNJw58uvJpGCQg2+dA1eFOp5fm4PkkdgfRbg49ekbcTcNW5vRYY/Ko20/iIgaXtc/F1fv32PQ2UiFcu4/Tyu65P2kLa0vsk4UWWMpxzIy72TiW8YFCFrNbYs4A==
X-MS-Office365-Filtering-Correlation-Id: 1c162fa7-61c1-4156-f15b-08d3d3299de7
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1489;2:n/dlHsr0w3/KyGJZBGOC+9E2dINo4EIfduU8OoPAMamwu6q9ED1w+8vedd6r9yOISzOYiKsq9xTpGO++BaZNfsin90GjQdj26IHJf18RWy8mNqLOi2w58T1Je59IohkICYUYC3Ou335mJVA0aE0pLlVVoweBc77gXjk5d/w5iWDAkJWCjBJktK5qhYi2oshi;3:GY5OgK8GeKuMbddiuNlKRviVqtJYEEtTuE/EMnj9Opqpjs1eQgsslE85lWe0uZljqBqwzHltva5v0141M0OrUMAf+lBcNcRLUfwCuiuAPt/KRz1wbVWW0Y6orOjo5q88VrO+ZGoBXSBscPLIdmcqCx1MgF7jjuJ7wkDPxoEDaN6nTKivhAw7MXkYBmt+xp6qRpOtY3rR2nkjWZGa3pfRYL3yBLZKeXvhVXocAxtCA/owcMsM4PijtOsjieedbTrUNb3x2MVd100wLNDGtEZJdg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BLUPR0201MB1489;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1489;25:c4369/jArm6L2WGbmgXZ20S0A+ZIQ9DTjS0XJsXotqhQ+zauLGcKajZCMdS2uJ8FnpXmqbbZDyRNgTzD3G0h7TWWmy3bCCZrAxWlST9K3JouEbXYsG/YZy8MneU67fPDBEvbAb7XOMwCRLeRWLyrgnCRBI+Rw75DuDcXHVEeiipum2x0yXi/M+ShVMpz1DGePZprMj7ezLqyd5Zbi8rBBjxdKDdSXqjK+AlsmQbG/Ku6x+S4VchUIL0Yhehrsg1zNQ0S7tJpmlyfkXtH4uqt+FB7h10xepNkPgrDqnjPC+/Yw09LeXGXL4k+OjXzoRpqmlIZNagQJOH/uzo0+kQQvAH+X4PIQnBryohvZiM2n3WNqLw1WITcugMyf8z6jpEU1vYbymBOGyG9fyxQ3PSVgvHhVfFi6N3tJP9dZzqs+Yv+485tfHmOs3XpvwpGjOn9sdG6bia5CE9O13qPe2u5PpxFwv2j3hRRBgkNswXpuo8fcWM+ZdXxpPaiG0eU3YiHDyYkGM5d1ENPF8DsdpTZ5AVfEZY61i2RXGeQWdu/kaR1+xgmH4fiecETVaFKUQ+1sxcbmFFP13RrQSytZeIrLM5Vc/WVqjC3frOrqcy5tactshh6ABAbCHX7XVjbmzHthjJOn4npZj7ji2FhooL14jMp9aNgZVi6OCbwBSWzwuKxKmiWCnVIdk/ThN9GxIIaBosXYWA04MDQQz5vW0c8mKbmS81gRUzYDwbOnozfUb2Ctn0AyJgVjqzEBhdfepwfDTs6l9ZPXwamPVN7AVLpfUwV6pdMdejVdoGI20oUpz4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1489;31:XYb1yOecIl9HngydRqVDExKNm4JldQTzGKTBCiUTrQEugiazvyKQbZ0b0XgQjhPgdz6zJyTE5faJtMuHAvfOd4yHqgd+vutFk3W7EN/qIRWZUJ0BYjaH5nlr2ueEXoUxD4pcKlKUhH20vGiscA/vbXpIBp2ovNjxyFWA6/TXghc/7NaHidkVZRyCWEsktfkUeYQDf1qUTMVX0fM+IJbmp1eqbL1xFBURXdcscENeBT8=;20:Dkx3N+sdUii6EbhZT2qheUYxnu0Uux3rPhZtuIbrEp0KKoVXXbAZEqEqUsmu/8dkU/KdhllQ5vPYm6OxRfTVWv2sy8ommIz68llf0ujqVu3+CsCvfh5iJe2tMQ4avqGWkJLZkZxWHJNoCchaGLHE+K6XNK6Ws9LJouynCOY0P3bdSWHqbhVYn1SZesZPF8mXXA1jq721YJpdBnn/9osUD3aLLMtPq7TMEgC1SXWj6Hq5rbYWjkHCMUa9maup+je2ys0e/4SYkhslboehbNiKHp7pW54d5AbRchiOvHGVRM5fSgASdjabntsIMrGKn0yFJuWvY4+P7TVMBqtlpZ8COyaEsavgbYafw59jbc+oX780gUx8uhcpa7lisOgt41FDrBXL5oqRuKnfE5PZ3RHTPTC6uNaqGyDybSW5SPxeq/iVVU9wL+aNn/95rKmEt9e0nk8hSiRso0ov4kFdoeaI2vSMqzfyh81dc3/EYrnXfwyvu76jRwHN0Nx9HXoaLvUw
X-Microsoft-Antispam-PRVS: <BLUPR0201MB14899588E8374E66508F7B74E2E50@BLUPR0201MB1489.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(13017025)(13018025)(13015025)(13024025)(13023025)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:BLUPR0201MB1489;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1489;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1489;4:SxjR0+vMG2e7h5LL8gU7UPrD2Z30ZrG/ucgDlAq5XNJLLIoAdRP7VyplUjUqEImc/BPB77NupJLWXFL0HS6U0d1EFJOG2FE/+hmX/dDj4eGxVZgLw2Y3dKA5XGdZoAA2qHN/SjFmk8JrPVSTxIlAuN3mBqHNAb+oRiSX2OJ1dyAfuiex1klNrio9RcWcuHABzx4wxRYLIAJKLXmnXT2VVsNDNLHsqnnGsddypkQmhd6jp0je7RJbNXnPYJwZYFZHIfvLxfS8EbKtSNjNNGGyVxhthtkKujiiJTxGE7e85vmhIeZCHFYwTBuPOAzlAiUHimcZMxKwMBSZe9kebyGToNum4guymkPlQkuuFhCenUszezJ4pd7oR71PFxvH2ECv8vQ8ztDHC34juIKDKll0zvFX8nERgakEwjQlFpSp/VVbw5VNnolfEvqxh5ccsrPgZLRPV/usrtupakTkgm5mnj2EgBtlhMhnSTANEYghcMIwxpw9OJSLgdcK7wo4LqxeLMfbTw799smdnadjxBeAS2aflpNb4NWUWl5LghYH5Ck=
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BLUPR0201MB1489;23:gD8jROJMNO1EU3z3HEOmyETnbo9DGXGFrCZ?=
 =?Windows-1252?Q?g0TMNE4PdEmiRbHxweXbU8cr8oUDkS65F06/eGLkGFsuc98kYruIx8OK?=
 =?Windows-1252?Q?u8EQkq0jE4HsJAU7IWk7tOlZDoDOqZLXo//o+JSiPsYCO6ZOgL08HlK2?=
 =?Windows-1252?Q?pyYuuu0laAbVihbtYZgDgoWtHWu7Vpb8Yks0knzUw6xL/qV7umc33rTO?=
 =?Windows-1252?Q?k3vD3h7vJz965sD0ZCaz86EZA1RAq2leCttg8r4b8MprZDDvxDV1CHmF?=
 =?Windows-1252?Q?lu/nzWto9cSomS9tMUAxQ3UbcYmfOQheXa4fYQ/AuFbJxj1wUhkXu9Zj?=
 =?Windows-1252?Q?OWzpwpL1v/sknaSJHhOU8+O2IyJAQebMk0nDkpq6/Eka0NL+Fquaimeq?=
 =?Windows-1252?Q?Pk7h9x+payiG/2bgkwpywvhiz2AIxgx40fb23cxWSp7UcskTidakU0To?=
 =?Windows-1252?Q?6NLeG1p6RIg+wMbI5E/xUvkGK0Gq5Ee38/EZuod9JXEEoP+D72s8gnod?=
 =?Windows-1252?Q?liWyvQBI1X2xBR5PHBTxKLnBomipQqfukIOCto8F5eQFMNVGMYsVVis5?=
 =?Windows-1252?Q?ZBxC46XH92S9Vv1l3LqQOwP3GhINH/6Zz2WT77QHUGvCgUms8Jw3ghIT?=
 =?Windows-1252?Q?w5/vKKJLHMY3QQh9vBRjXwdZ1AGZ5zagqZr565kYC07NnACqJ392bCCa?=
 =?Windows-1252?Q?Cys6pcft6lcYAa8fYfjj/DB4waD5CYxu4vRPFNM1tTewhjEG3kxJuPNY?=
 =?Windows-1252?Q?VHnuPBnydSKQ+lInABEXIxrUpd9uRDMay/+3aG31rd0H4nSnEXOmQY7F?=
 =?Windows-1252?Q?uLn3iWLqDc65mWFubO30VSB9S0s0e1Q2yNTkafW3d/Z8d2ok5w7qRn6G?=
 =?Windows-1252?Q?RdiVSgfR3/SF5XzqpLyZjKKWbnR3uw2NCimqe/DtWTHCuAazw2rN8wiT?=
 =?Windows-1252?Q?NxbV5jKm2jGib0sR5RBEpZeiJ5+TTPBQ5QAkKlr+xfL3drw76VnbViib?=
 =?Windows-1252?Q?eMxhnC/03g6nMFgSNGYogVcasp0ogyT5iMcfYTsBmEbCqVPgZqe/P2MZ?=
 =?Windows-1252?Q?FsPIrZGiHyXOIJQbud0w7bvpp3ae2raAVt3SvEm/2YHQV9mZQdibxWKr?=
 =?Windows-1252?Q?9ucigFJJQ/qscCybMXjjrIES5PmHmoWvnTKiLQc/ZiIqznalOp6dp0jl?=
 =?Windows-1252?Q?J7YcfNaBHQXe1m2mNoKNVrYQzeKPTzxpOIjjuQhUa66FfZiEHdGNybZ0?=
 =?Windows-1252?Q?W+OII9TPJofksu69qMfp+pGHR4128CfJ76ekrnWP+pzTmzxtzNN4aZhd?=
 =?Windows-1252?Q?6pQ2igHeB51zIA7TrOv7DMibPprm9iscTbe5OQySSaTwhluvFvUvu1rY?=
 =?Windows-1252?Q?1w7qWHKA0IVgA1zWGdSqL27t7+DHyg0ml/H7TkBq9DKKdcxaruG7QYPK?=
 =?Windows-1252?Q?S/JDafuH2jCV5Zd5E3Uck?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1489;6:+0NxaKqV0hGuR+Jk8BD5n0USQrWSGfWm1CTcoAoOUEL0W+kjYOtz2NLR1JlctOf81ne0qukozry4+RtujctztglY4Li+6ZUz5Uw5cXIjlQpYIRlSpUMm2G+1aU6C+Q+Pn1equan7kIpf4DgKAD/0W68kcM8w4sDvWkC4Bz014TB23qKNjh1sPlVvLkk7oFtqyfENRvupefevzrUu5mIvxUJyPGCc2WK4GCvn1wi5HPnKcqdyoHBIbn9ZjGG8xDYPnxELQTvIygjwiABtFLaKxnFrCnIJG16DO7Cbvjqh6w7fPE57Xxh9qWNZFWbV1jfnpmFZWxr6G0IiDMuvfmU2eg==;5:bvDpaCWqRONrWUk5w4wI+YXiUTQcuK6AZtyHDIvuyza/Q3LNvAw0hic9qgTuFLj7kXH9Skml7AIpSAFIS1SM6ANseP5EiZ7rOHnUhlb4Q83roSC0qa/xtZcqjS8X4X4STli7a0J4wx2UdXYEPIQyWw==;24:nCnGPFHNQMl7yWsfEg0A2/Sx7xLZpmURU9oVsEkwPsR17g/M37i9T7EhatYQJWn73zMQc8bo5OZTyNuZWi/yPJWIxm5+0fSmLeDUcYVBuE4=;7:G7EduJone1PYFNuDJfLCRmDwstz2kCiU76RAhuetScUXabVg/zmW5zKbUaNe+lrtxH/wAH8NR0RZS6GCnHq6Uj/f5p5DrY/SsKCcF99UPjO10fJLra8Mo6EYDBHOMziXZZZ+DrdoTpThZLGtwHjcMwk1fI7QQp17CBWUAppA7LpRK6tpV/YE9C+0V3TRf48/tagAO7QcftMxSuF/ZaleVt0vWm/mZlg3O/QHtga8fzCOcc0fzGkXhoxR7A6orUsb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 12:06:48.0402
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1489
Return-Path: <michal.simek@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54987
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

On 2.9.2016 13:46, Zubair Lutfullah Kakakhel wrote:
> Hi,
> 
> Thanks for the valuable feedback.
> Comments inline
> 
> 
> On 09/02/2016 11:27 AM, Michal Simek wrote:
>> On 2.9.2016 12:06, Zubair Lutfullah Kakakhel wrote:
>>> Hi,
>>>
>>> On 09/02/2016 07:25 AM, Michal Simek wrote:
>>>> On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
>>>>> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
>>>>> based xilfpga platform.
>>>>>
>>>>> Move the interrupt controller code out of arch/microblaze so that
>>>>> it can be used by everyone
>>>>>
>>>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>>>>
>>>>> ---
>>>>> V3 -> V4
>>>>> No change
>>>>>
>>>>> V2 -> V3
>>>>> No change here. Cleanup patches follow after this patch.
>>>>> Its debatable to cleanup before/after move. Decided to place cleanup
>>>>> after move to put history in new place.
>>>>>
>>>>> V1 -> V2
>>>>>
>>>>> Renamed irq-xilinx to irq-axi-intc
>>>>> Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC
>>>>
>>>>
>>>> I see that this was suggested by Jason Cooper but using axi name
>>>> here is
>>>> not correct.
>>>> There is xps-intc name which is the name used on old OPB hardware
>>>> designs. It means this driver can be still used only on system which
>>>> uses it.
>>>
>>> Wouldn't axi-intc be more suitable moving forwards?
>>> The IP block is now known as axi intc for 5 years as far as I can tell.
>>>
>>> Searching "axi intc" online results in the right docs for current and
>>> future platforms.
>>
>> yes but we still should support older platform and it is more then this.
>> This is soft-IP core and in future when there is new bus then IP will
>> just change bus interface, etc.
> 
> That makes sense. I'll rename the driver to irq-xps-intc.c
> and CONFIG_XILINX_XPS_INTC
> 
> Please shout now if anybody has issues with this.

XPS was shortcut for design tools. You had CONFIG_XILINX_INTC which is
IMHO the best name you can have.

Thanks,
Michal
