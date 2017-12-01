Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 18:38:49 +0100 (CET)
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:20256
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991100AbdLARii18w6L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 18:38:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IGKj7UexG+a5w0+r6nIY6t/6igrPamG6rqz/JAHnqnE=;
 b=HacDo2fSJ9ozPN6SBOqmCnHS84MQ3sMAeh/Zd1UOF6NDblGSdHgzj35v96ySQliPRyxYc0GZI2EJxtbLxzBL21S+1xz8uQvTwyyooBhFzssQjElPqX81uGe4TbzyAbMe61vs376ESahva6mXk/+ASZlMpsNAcpV6dmNweMVNUtI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Fri, 1 Dec 2017 17:38:23 +0000
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>,
        James Hogan <James.Hogan@mips.com>
Cc:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <Paul.Burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
 <20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <b999a736-8ad6-824f-36aa-e7c4cb7e467d@caviumnetworks.com>
Date:   Fri, 1 Dec 2017 09:38:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0022.namprd07.prod.outlook.com (10.162.96.32) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7988d111-9532-4ab2-6e38-08d538e25385
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:vWdAvcicDaSC9IhD+TTwGzEcqBCmODb44yjgnZjGCYPUe73SG6hWmOrVOfOHDsjRW3mAyy0n0piS0rKgiV4dGzkuitJfW7olTAymzk/wpllTLuvkl8s9BbtjbVLSd0BuM5+PcM+3QQHeIGapsmotGQPDlPpCd60/leC/Wx2+dkNb0Oi1V+I4AmgO3bmrJWsIHRVtMjYtFbEwzks/Zw3ITQGNOIRQ06uDv79vWUQzduLrVV1r3KuUpKyeqRTNIqc/;25:UMfHJuiha7JxBXgjSVZfAEPPiAFyEXRrBKvIw73vYJNpyKOsVCI6eCHLVnbUONG0cGsX5CTEJgCQMb0DEaLisl/gVbhgsGtSjoVxeZFgEeUQ09+ppDO8Owbkv2qaCXi/cDCQsq0F7qVof3Oc+dsv4ExMQNSfV9VeX1pgEcpCUwcwJwN1jEwBjpaXOZefCzHNquaiiAz8AxU89hhxNQ8dtNYAx8qYi1YeOYXfEJgUFpMB9AP0XNXd23/PV0TJ0IrHNKUpgdmy3kAUEbTCqQomZzDjiznVFj4v6nlQ0vrqT9IvHyB83tyXiodw2Nv3ndoEuCTklz/gP7WooHfNKtLzxw==;31:+o25vXsxC+JLHia6PEWIbY1h6vTmq9Ll80Uh1S6HNSO2Ys3LnHV5viXyiJzHXuU3v1d2yXLtqI39S718lgDGK7TldAtzo0h+ZpGaxq3haoicL1hZNH/DDupif9DD8zvUAxTCajgGyg0TwPMT7M0LD6/k7Tn7Hzxz6V2YzEgEqjXAyAmOcNrp8HVXNo+tPRNDe9LPfhJrpS4qUg/zqihKb1S5hFcPBXGvdINlJzNMYsc=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:9M5+B8ecsSyXJRls/J5KysK9u75N1AgXUxsI3sj0PbC5R4t5FUYvtkulV/57A4VGHY6ese6lHWaXxw/Tz7wnsaSZmFlbnKpKs7/6U0nuJEl1cMeZGNiBFiuJLZm18pXfGS9CBa01fDIESCZUP3YdrUIyvLAVYxehFUT8u4UBF128rk0ADtH9r/hmFVC3dN6DvIRB9AL7WB4Rz0Y8pslMeIwkSuukft54qJjPVTZtEgv0Oh3rP6aAvYVdesPQMO2vbExSHcLzC7QSgo2dtAYgqa5xsjrJHl2iXAJNnaoz070w03/rpRCOFd2HjnlDWekybyPBkTB7omBiKvUMV67EqLFo5CutBgKF/M9aFuJwETJv862QYiJ5Jn4KxeaUbZjTd9fQLnzvDmTEytmRoMREH423rR/1hsZr0TF0LOW37KxDknqSW1S8uLb0cXXwyQYSJFtiBSJ21tU307u55gg/NK+4m+kBX5bRtXR+5Oy20qiDIhwrhehZR23dy15TOQht8H9OzbtpGOL7u/Dt7QoACfhkUQCDWJXXXE6yrfCCDuWtIBpkB7rwwZIFab3OL//Lgd5vGtklW14VBsiBoPD8iTqGPu8KFHB7HNQzxtmk7+4=;4:ZN1A7KxaZqm4FfCCq0LaIdn4qrbWIJ00e6jAdqwx99+2yDRCJlCGfAhih0QaAdkmTNwRVxdRjaO35docW3V48kTcZ68WfTxIo02C8JEs/wupuVuwSgJKbH+sZ9Rle230VTL1ilPBbuGbMUIBMmxftaB+a8BGv/HqxATXo6iUaC/Mr4I3z213fWvHtljz36tMX1ClcrM4sTsppq0FXomWK9A1pe5mSlzKUfzL1W7AQP5XzKUMsdcnAZqeUVI4Dx/cO3lQ3SLabsqqRNWgkru47g==
X-Microsoft-Antispam-PRVS: <MWHPR07MB3504FE7294645F19D3B58ADC97390@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(10201501046)(3002001)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(346002)(376002)(189002)(24454002)(199003)(6306002)(6512007)(8676002)(58126008)(81166006)(229853002)(93886005)(305945005)(7736002)(36756003)(6486002)(7416002)(6116002)(3846002)(33646002)(97736004)(6506006)(81156014)(966005)(4326008)(23676004)(53936002)(54356011)(2906002)(52116002)(50466002)(2486003)(76176011)(54906003)(52146003)(110136005)(53546010)(72206003)(6246003)(316002)(16526018)(31696002)(8936002)(25786009)(31686004)(53416004)(68736007)(101416001)(67846002)(83506002)(478600001)(65826007)(189998001)(106356001)(42882006)(5660300001)(105586002)(2950100002)(230700001)(69596002)(64126003)(65956001)(47776003)(65806001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTA0OzIzOnR1aWc1cGFXVE5USTJGQWY4enZtOTlFWjd0?=
 =?utf-8?B?cit4a0dTS2dNQkl2YlQ4K2V3dVBqcTFmMUxUT00xQllxanErenFCaHNRMFYy?=
 =?utf-8?B?OGkreE93NDJkb3FuYUp5UEdBYnB3YTNvRHF3WTBucjNlTTRRcmpxdkFhYnpC?=
 =?utf-8?B?MHNkQTdUT1JtakFmYlJINDFCZFNPY1pkT1kxbkJZZDNsR3k5Yy9aK0gra2Y2?=
 =?utf-8?B?aS9SQnY1VDVvME1zdTJhZ0ZtR0M1UTlWRC9YUFdBeWpjdVRDVVlBbG5vK21D?=
 =?utf-8?B?Q2RGRXUrN053dWxTR2pxY3Z4VGJDWWxWZW1MTXErVXFyQ1RvQ0tmdDVHMVo0?=
 =?utf-8?B?emNmY3FvMVI3S3BUMHJmN0E4bWtUWlRkSHVMVHl6TTExVVVON0pQdS9qemJW?=
 =?utf-8?B?MnpwOVRWM1pUcm9NYnZCTm80M0ZNSVZUZ04xQUpjNWY0Ry8zaGZPNm1lZ3Rx?=
 =?utf-8?B?N1FGOWpGN2hHMGxaRFlUTW1aZStkSGIxdUdtV1pxdllaY2drZ2Nua0ZhbFRo?=
 =?utf-8?B?RWdPVkdRNmROclUxa3dOVVloRnQ4NnlQVUFqVE5LazJKWlkybitWQUsxY01h?=
 =?utf-8?B?MzNXcXdaVGVJV1ptTW8wRzhISmhSUWo0NU1KdytWY3Exa2wrd2lwcWpJWjRT?=
 =?utf-8?B?Tmdkdy9oQTkxSlk4eXEyV2VTVlpDYmJJS2VYQXIzVUJqdUdOMC9PMXB2UTVR?=
 =?utf-8?B?ODVNay9xRVNRNHlSTDEzWDBUaVdDdEhkVXBRQkwzd005VzIwVEhQQmRqSzl5?=
 =?utf-8?B?cHVIM2JkYk85SUI4WmZhSDJCdmNZSlgxTW56VGFMcDNzbGRsNG03Vjc3NS9U?=
 =?utf-8?B?QXFzSUFzYkpTVHVta3FaZnMwQngxZTRhVks0SEJaS3djck94MGJCS1VjenNK?=
 =?utf-8?B?TmtrUmlMVmMvcnhsQmZURzNCOGtpekI4LzdmY0k2djVLbkZaUVlIcGQzWlEx?=
 =?utf-8?B?ZThuRkpPMVVhd1Azdnk3QUtaMTBLbW1EMnVFbFJrWXJyUlRPdDcrOEkzV3Zs?=
 =?utf-8?B?MTRZRjlIYitLaWNUNEt3TFRac2c0ei9WR1FxYXVpMkpEU1pla0ZkbzNzK0p1?=
 =?utf-8?B?OFNIS0I2Y09VTENicFpVbENVTDFINFVubElEQlNvcGdoSVdDTTIzNlA1dXdP?=
 =?utf-8?B?MnFZNlRWRWE0ZjUrUExxTldWalNpMzhQc2thKzd0SXdFZjRSYlF0ekR3RVBy?=
 =?utf-8?B?cnUvYVJJV25lMTNTOXNQQ0d4UGNCYy9sWlk1M3V5TE42VXNqYjRRalZ0K2Jv?=
 =?utf-8?B?SldhcU5hNWJ6N2ZCQWdidGlQc0FzR01qMUdYa2JweWlQbUw2K21Bc3B1ZGFt?=
 =?utf-8?B?ZWsvdXYzSU1CdFJ4U21jTTMwcWtPL0FIdTFOOFpHcG1KL2NKMktzTUhVNXJ0?=
 =?utf-8?B?QlpnNFo3SU92bkNubEVrSTZlMlVOUG5pYXBqOCtHaXhPYVFZeGd3M1c1WUxu?=
 =?utf-8?B?dE5nWHU0YnY5L0hLL082NjMzdXFXMktTelFDMlYwSnRjOHZ0cEtCQVJGa1NJ?=
 =?utf-8?B?TXpQU2dEL2FLZU1kT1pPUG4zZ1Y3NUhlM3JyZVN1QlFrajk1QkswTGpkSTk3?=
 =?utf-8?B?RUM0ZXhZSUc3QnlzNWRIRmt1M2pOWTRoM1JiOTU1TmZ4eTFoVGZ5cWZPekVQ?=
 =?utf-8?B?ek5kb0xJUHhma1IxbXpOU1NlYURjVm9oUkh5TExITWVKSXdEcE5UU3R4R1Iz?=
 =?utf-8?B?OW5nbUxlMzVKWWtiOEc0dytFQ0p1Q0REVFpKNFBheVRvVklNSERyVkdFbXd0?=
 =?utf-8?B?bm5GK3haSkFhZnZoTzlOMGl3SWsrL3M4K1RUQ2lCMlE0MHpCb1RFT1FqcFB5?=
 =?utf-8?B?dHYwZUVtdFl0R2lSUTg5eUJyKzVyUTZ0bDFSUTN5amNLTWhjR0JHNEQrUGJO?=
 =?utf-8?B?Z1ZUYmtxVG5ITWR6aFNQK2tQekhmYlJrWEYzWFI2VU4yR3NwM29WU3NMcm5I?=
 =?utf-8?B?dXBSZVJWWVZvVTRkNnIzc2FUZXZ2cGx5RTkraXg1QW9MN2VEK2RpcG1IdCtS?=
 =?utf-8?B?Tytmd2w5VHBueWlIaGdGL2tUQnlZMEdIY2dUazlhSGVSd2srM3VhTHlDWUVR?=
 =?utf-8?Q?RVkY=3D?=
X-Microsoft-Antispam-Message-Info: mi8yr67OxTExThsmMpFl3LMsvsBLrgOiJMMp/q5GSY0gxrqcfu/4tp1cCZncnlAKgwkm9EvBVtLPzKsOrgPWXw==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:jjOx0vq+k4Qw8tJQ+n8uiTmD9iMWX7mArD+wRA0lhaEf+UHIii21fNvAMua/QKiglj8w5WpdHQle/bS/GMtu3Ogqv6MJKv/1hN5xeg9A60wR39mP6B7nmsFV3NRlYJ9KQvnaJOImF2IebOn7W7fyW7UEGTThI2Pk88xlqomouXnNCkBQP9CsHHIYkd1L/V9QHNs6/KRmK4NeoKGeH3bJ7fZRPcS36JRK1a3d/gJBKPR+azSPEfZf0C4Hr4b0qFCSpzRMm3Tp5AqLkLzRNjGMTK5EZ/PLnvpwTSXQAK6TJ4Mfh7Lp1U1S3VKsh1XZEjpOV8/eOMGWZCrr2E13JFT9JsPWUYrv47oPKg5UGc216Ug=;5:wRnhWbLpAg9wwsj8QASIGDO6krSzn6UExlXHuYuFB2Scn1pvpQai+7DXeB4n8qCA+nGwic4h8wUBE1Hwei7uLbbMTeuprd8iS3hDU1Vn/l7UDxFp/dBCevTVslgdltU8D+NKy9t9gEPw0E460o/aadGw2cqCJFUAB2ucDXQSm/U=;24:pFejL8+Yn1wGL/qyaCubxjIGTwguaKgNpTAaexooY05A+bCLqJ2Ogp/nAw+LE+WOa5wde8J2WOYP3LBo6jmvA9fJdnEk2YAyPnSlLKggPpo=;7:BL6pclJRDi3fG6A0GAzKYx6AasQ/QGlzUiC+Ci9U6FpKMDDSzVuXWa7beibrazPRVUW4cJwyMN5Sy5bhaWNWXfT2Vi6Gp/Ziys/3GIRmlfIUWGH+vqBPx7bovtK15W+ZqR1anyNKqEwxE/UIsoN9jVSrOHB7P0e7Ialh7VeDQtvJWM9fsYdcKgxuELz5HsWIhItwySIQ7SWevOGAhsjNARVKSR7vf7YrmO+Ca/y6WUBdEDTWzaOnp0KhfDAjnujQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 17:38:23.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7988d111-9532-4ab2-6e38-08d538e25385
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 11/30/2017 05:06 AM, Miodrag Dinic wrote:
> Hi James,
> 
>>> We do have PT_GNU_STACK flags set correctly, this feature is required to
>>> workaround CPU revisions which do not have RIXI support.
>>
>> RIXI support can be discovered programatically from CP0_Config3.RXI
>> (cpu_has_rixi in asm/cpu-features.h), so I don't follow why CPUs without
>> RIXI would require a kernel parameter.
> 
> The following patch introduced change in behavior with regards to
> stack & heap execute-ability :
> commit 1a770b85c1f1c1ee37afd7cef5237ffc4c970f04
> Author: Paul Burton <paul.burton@imgtec.com>
> Date:   Fri Jul 8 11:06:20 2016 +0100
> 
>      MIPS: non-exec stack & heap when non-exec PT_GNU_STACK is present
>      
>      The stack and heap have both been executable by default on MIPS until
>      now. This patch changes the default to be non-executable, but only for
>      ELF binaries with a non-executable PT_GNU_STACK header present. This
>      does apply to both the heap & the stack, despite the name PT_GNU_STACK,
>      and this matches the behaviour of other architectures like ARM & x86.
>      
>      Current MIPS toolchains do not produce the PT_GNU_STACK header, which
>      means that we can rely upon this patch not changing the behaviour of
>      existing binaries. The new default will only take effect for newly
>      compiled binaries once toolchains are updated to support PT_GNU_STACK,
>      and since those binaries are newly compiled they can be compiled
>      expecting the change in default behaviour. Again this matches the way in
>      which the ARM & x86 architectures handled their implementations of
>      non-executable memory.
>      
>      Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>      Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
>      Cc: Maciej Rozycki <maciej.rozycki@imgtec.com>
>      Cc: Faraz Shahbazker <faraz.shahbazker@imgtec.com>
>      Cc: Raghu Gandham <raghu.gandham@imgtec.com>
>      Cc: Matthew Fortune <matthew.fortune@imgtec.com>
>      Cc: linux-mips@linux-mips.org
>      Patchwork: https://patchwork.linux-mips.org/patch/13765/
>      Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ....
> 
> When kernel is detecting the type of mapping it should apply :
> 
> fs/binfmt_elf.c:
> ...
> 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
> 		current->personality |= READ_IMPLIES_EXEC;
> ...
> 
> this effectively calls mips_elf_read_implies_exec() which performs a check:
> ...
> 	if (!cpu_has_rixi) {
> 		/* The CPU doesn't support non-executable memory */
> 		return 1;
> 	}
> 
> 	return 0;
> }
> 
> This will in turn make stack & heap executable on processors without RIXI, which are practically all processors with MIPS ISA R < 6.
> 

All Cavium processors since OCTEON Plus (more than ten years ago) 
support RIXI.

> We would like to have an option to override this and force non-executable mappings for such systems.

This is what I don't understand.  If a system doesn't support XI, then 
no mapping can possibly be non-executable.

There may be some utility in disabling the use of the RIXI bits on 
systems that do support them.  But no command line can conjure 
functional RIXI on systems that don't support it.

Also, this does nothing for multi-threaded programs where libc sets the 
permissions on the thread stacks.

If you really need something, at a minimum, use the same parameter name 
that x86 uses.
