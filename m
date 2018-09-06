Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:32:45 +0200 (CEST)
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:19232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994648AbeIFVclCuFUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 23:32:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reRx9/WydmzgimK7060dTVmAqtE+GjIrif7Zn2xD5XU=;
 b=Mw71El3H0n342Qcq9v4MJQF9h4reogZNsy0/93iXng1garV/UcMckCqhEmZH/GE7CARUlji2CyIBmu1uJQpKeYVaU6yIA9E0r4MYB+1MMWIvNs8NZgtj6S+YQT/vZR08SEWhucI3hrmDoIaKa5hT4lknHrgzClWnu6+nitDDQnI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 21:32:30 +0000
Date:   Thu, 6 Sep 2018 14:32:22 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jiecheng Wu <jasonwood2031@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] ip22-gio.c: fix missing return value check of kzalloc()
Message-ID: <20180906213222.tnuaog7nte7hmddw@pburton-laptop>
References: <20180817014616.6488-1-jasonwood2031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817014616.6488-1-jasonwood2031@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR1101CA0016.namprd11.prod.outlook.com
 (2603:10b6:910:15::26) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1246684e-5c6e-49dd-a22c-08d614404069
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:yTpLSSLdmkHL3P4VEu/TmYwnQWrH+rv59XpwB5nHd2wXfoeaZN7nxpDAP5KjVEpmBj0ncrdRmUAFSllFdJfv44fjOKS8pdPv5ye8bBKTvvEDG43VRIuRKoUC6onBCoLX1wOK14iY3WcZ3jpcQwzJZg24Y3+Tc4z+iE0ODVSoTozZH1Y6BoT+1YTc+bhmmVK5r/1HNCirDh0dSeMHUflwaVC/RDJ4X1NKp7lluh6Nwwv3xnjSYvr17z+rSBJiS4TA;25:IbZwrgtPzIAUD+Dg14Gfyb6yYKhziyhfyp7NLVmT+4fybmkCcsqUVa3mOxxCmmSgZFrweecaHge4BmTn87mz5a01X0qv4QmvMFRlKzFISOAfcAVI3n8BNhaPkrZhNM+YnCXlwhYJifYtw4jTkNHXPfnx9Wf3Nci+fQY/uKQeBp20nFkNb3VAGFvXRi0aLAzGIjvvhLsLSNeEwBtBvugyrc7mkvWQkaxcSOk/XAEkbnQqBm78y2lEYZxI/LjoHsqZsbfkObFQPySLP6fMNWjATyiDT1vXbk1AOQaPbe3C2B5M+RlOMTClra2ya6lLlpAipOtZjmYyKrilLIyG5n/KeQ==;31:L2dJmLetcVm0JLZwAomUwy/WFuRu0ZhLh/qJswyfdubHc2CAkQGWrdLGsF2SCX7y5UKw6V8WGs8E4Vn1zDbNsy6EjbPu1qYbR7gVRK8jAHF/8dcoqybggHzTpAp17rpLXYfbb3WuEI78x0LqfEBT6/WWx9CEPA/IFKvELAPAFlLHrAch8zEDcEDSOQM09oU2lqJ3sH6FjBGJiwOSvN77nkjb0alqJiDHgweU2/V29Gk=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:yS/w8Ly+vLakfuMmfWyQKdLrb/LQk0VsdWmFlvU7MMs6XN83rmq7C/CutqMViPcOvMgBVbDrRJh+yNCgbPFOIgnM971ruDcQvosFl3oNmeZX4w/c3RmzBOZYcsUb8EoD2b7n/cVJFx/VfVMuf90DTIS1JqA+bOiNvVF6zDONxDo8eW37EDHj0Gs4Q8iNyC4bIbd+o7qQOqCHAcAstdJImM1hS8gABHxwbeNF/e81DV69heiB4T9U2kEbMgDAgaGI;4:abSa9sUMsZcUxf7Z2wsRmqjjrn3r/zCWl6zJiiCzJa4oaVsn4erQqzrkn9UdoS9ZxHRo7G/GqModeINMNp3j0O/kn/gco9WqKVFXjd1aO5f90QiQEu4hC3pZue+Ne6KzMqRid2ocW5dsD2pZMGI8YjP6uaA0qn2d4o8vxT+tKKMfv9SIVK/nmz0X9b4OdcBXqPg9+1JCIv0ZD+TeLcLa0UbrKLirDXa3DLdq9EQwBdC+ycakfXEjynOrLkC5xD0pTbvSw7fDCH1Ctsfw3VXyUA==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49396E4CAD8596990E99316CC1010@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(346002)(396003)(39850400004)(136003)(376002)(199004)(189003)(6486002)(8936002)(9686003)(229853002)(1411001)(97736004)(478600001)(47776003)(68736007)(66066001)(6916009)(53936002)(44832011)(33716001)(105586002)(106356001)(8676002)(186003)(50466002)(1076002)(76506005)(5660300001)(6666003)(16586007)(23726003)(6116002)(3846002)(58126008)(486006)(52116002)(39060400002)(11346002)(7736002)(16526019)(6246003)(33896004)(2906002)(76176011)(305945005)(476003)(446003)(316002)(42882007)(26005)(956004)(81156014)(4326008)(6496006)(386003)(81166006)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:0g2CUvO+APncMeeCw+GNTm+CYoNRiklnu0f6KfWJk?=
 =?us-ascii?Q?WFD+rn43ImdqWlkXI2sSA5VQ7yy/naz9fmc0+Rb3lHymM8BXD41Fe1V5gSpl?=
 =?us-ascii?Q?x/sPF1Yec3c2e/WmuTjjp+sa+wE/sNiiraTv+wri2mIpkqmVdfzBwSTJTSxk?=
 =?us-ascii?Q?+07AjsTEL5ZsG14HgIQPhZYP7/Uj5UkpaiV3WTyrujT4hzokHCFZoSxCnHD9?=
 =?us-ascii?Q?mAs0C33WvARJw16R9No30ympc9iN3FzOPN9PiSp5c+cUtAEPKNNU49CXtFex?=
 =?us-ascii?Q?i7BsHMdO5AhHZiOitlcWtq5n46HkN67pOSBF12lwxocyoj03GaGCikhYsl2G?=
 =?us-ascii?Q?DoalCLXHPKkwVqP6Cnwd7HIop7mexIrwguMQEIdlkWHcbbRC3KFis7ZPEcle?=
 =?us-ascii?Q?14OGpWCG9hfZbnLvAj5w/POE9BKs+aDGJEj+7IAfJ8p4t45mwRVVCFM6jFPp?=
 =?us-ascii?Q?+SKYf4+4Zi4MP9rEjuJmDK9BbVzJG8M59rFQ+xT0dMNghkuyTU8vNeSPBlBP?=
 =?us-ascii?Q?YyDVjCeLEx8F5OgNNWMYwamzW0CTY6RBqLKjf/karoBVjPBbAvCBpPez8xl5?=
 =?us-ascii?Q?Vvq0C7iQKZYNma+gCG7K5S9Ew95+t7n8by8KBzgjkEFu7BisEnh6cJo1osIu?=
 =?us-ascii?Q?7Ds42lrVlmF98bmucAjne/Km1IqJb+gEqDw525jRZGIgxr0MZXT78Rb47lsL?=
 =?us-ascii?Q?H6cMq/6hF3v2Xw7R6AJ/OSVcx1iRfTzkAprqLw0RW22BmGsgWUasZIRQccSI?=
 =?us-ascii?Q?S8n+99+ws1T4/GKxh8yPWmfHWw+vvQxi5q9BQ8yaRIfqztUCKgeILz6/+K+m?=
 =?us-ascii?Q?TAONdH5StlgF1cH/uJEFGWZLoIsizgca/s+3xXso726JL0sHNJeevml8NzGL?=
 =?us-ascii?Q?qCdL9WQ91WcrpjYO1dasvEhgUzZNx9/dui3uB8Rv99EIapY+ptcOp8Eo5tYC?=
 =?us-ascii?Q?O8Tc0k3WdLtEFPCKkfG2Y78dVxhCjvSYE1b1eJJBR7elAjDdIR2dPLra10xU?=
 =?us-ascii?Q?1brP1b7cgzQNutv3LEp87Di0LS3FI1GUO06oX1szvqEjJ8iZLy2r7Z+T7p7l?=
 =?us-ascii?Q?H3GdppXUxXytep1Yn0ztXo6COhqcuPZL/fhOE2/NSqFkoL2AZgKzKGuupwQ1?=
 =?us-ascii?Q?f5oWrlsNCEA4QOs2o3+T9pysztrruY93RTeZHQ7hNc9CMW4jMA5RgQtRpOXx?=
 =?us-ascii?Q?cG3UeDYPgyfDTVOkI7X0aB9LrfSTwlBKscP+HWvvHhMQF8ELE3+2cMJ3mLGq?=
 =?us-ascii?Q?L3JH5n1gFSVSMtOJcPHxPHuKeIMFIenFtVIn2rD2dmGocGkjFHZFh8RV2xIn?=
 =?us-ascii?Q?2k+sUX67Z0fX9K/sH1hOd9FDnnPwumC7PYRIezVDiwA?=
X-Microsoft-Antispam-Message-Info: qGHYYn4NleBrgbLOFUGlKZTTKsaAK3n5ijTV0Nm9kWlLlsb6xn3YSZkVsca77pRh+9l/VzGsZZsTvcXJxeVlh1XjTfoAKusb3CP3DQDjI1rzgdybKaTwV1BIwNCZMTuvRg6qVi0jTKL8/cbAAssrjHkgap7xUsesRZ9ZODsk1nsPp89Ws10xBy2ZQtHWq1VXdfQrmCmUQitytlC3gKyw2eOFmxl0lp4MPBHQT0zYX1VUKrcHfpfn1ytv9s9SE8xLuyJHDB7Ums82nWbWAxtpbqeY+lRfUzZNLQ6MwFlPzc2kZxa/E8W87F2bBeO0nWcn3Uiu+xYvWbxoW7J9aGkObAEZB8BVyajv4yhRu5B7/bQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:5poAJFgZkb2zuLPHFZR9v2opoj5w7WyrJoH22T324pTZDd9tWxpfMPEIQW0nVIxput80lFjs5nQZDlz2rcfDrwdYfbF/b6LmKbouZYLHNQTvMKbXCN4qirJcRzT2jmJBX+DdQltIco6I9C7DRRJ6Nq/oPMj3rY16ph0Awq7krLxSQNyICSO6SctHmlNu3uDEAktcOCXuj3JYYu3X0d3IzJrljxgMfLtfMxUPbr5LhUEJ3QecVdBuMLrZ3IPSuQ+jG/0NK1VSpj8Wadzi1Fg/KRHpMbQuQCYoLyInp5cW1TPzPPRdtr66OGZWsIJsEZNSfY6/ayozSVICdWwc5fRGUL70oXaRkdMVEzUMgs33hviwltNZoh+M5srmw/DYT2mM7hbGkVe9LLg5Sa2Ft19c565hKot/piJMbeh24ArROe24Xg99eao9rw57CFRPa1My4Tts1HvfCCwqtDpqlEBtpw==;5:6+iCyDWt5bkiyzMjujS3h83a1LG3hKzuE2TKoxxZrK0wEz1dJk3FHQu9334bpJFpy+Um7kYIzMF56NORReY47a5L5dUljcuR+ddDz3Bn+gyx6jPFGEu9+RPed+hqX7BipAw+odq+TX09zlaNtTB+NBkOXVP5nhcU5xNMSOCdnfg=;7:9/EOuVHDOuY1ejjWHddYGwTQKySjdcno2rRyKdZk5UNlQb0BBxaOvEE9NwPBfKySwn4P+ivM2IyY52aIqRg3o+tKZ92ad0xLkuiWFhQ9fs/B9aOmM4I+/H/0PcQ0bm3omdjqE3OInBYlKR3xrPy8hvNvybCUgtCC1LAlLmLVOLGaIKL+RWhCsl0oa/hsoIDdUWcoz9ZBk4cGrQ35mPmg2jpbdZ1/i2J83XpB05aLfGetfCgZUiESU2xycB8HFB60
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 21:32:30.9129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246684e-5c6e-49dd-a22c-08d614404069
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Jiecheng,

On Fri, Aug 17, 2018 at 09:46:16AM +0800, Jiecheng Wu wrote:
> Function ip22_check_gio() defined in arch/mips/sgi-ip22/ip22-gio.c
> calls kzalloc() to allocate memory for struct gio_device which is
> dereferenced immediately. As kzalloc() may return NULL when OOM
> happens, this code piece may cause NULL pointer dereference bug.
> ---
>  arch/mips/sgi-ip22/ip22-gio.c | 2 ++
>  1 file changed, 2 insertions(+)

Please wrap your commit messages at 75 characters as described in
Documentation/process/submitting-patches.rst, and as I've done above.

You also need to add a Signed-off-by line at the end of your commit
message, which indicates that you agree that the developer's certificate
of origin applies to your patch - again described in the document above.

Thanks for your patches, but I won't apply them without this.

Paul
