Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 18:51:36 +0200 (CEST)
Received: from mail-co1nam05on0722.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::722]:14314
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992907AbeH1QvaZkTQ- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Aug 2018 18:51:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD31ls/ipaMMP/Ux/xGkk3S9ZY1VY3kPfdi2/Zv0bjI=;
 b=DgFxgw+frMvBrcnQfvZ1bWrw3smOZAKjY6snRq/LXhP8dRQ274slMhe1LB5qymRJCU7CMc7vWOM0NZMsuEDr5AtuSCL+LGEAn3wUbtwYwjz2ZlOZv5YlPKrd95z3QLkGQDFlAe5HBlX0lpPOrmgAXnmn+rWL7VMt/6dtjeflKUY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Tue, 28 Aug 2018 16:50:46 +0000
Date:   Tue, 28 Aug 2018 09:50:43 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH] MIPS: Loongon64: DMA functions cleanup
Message-ID: <20180828165043.bxizejhzsdxn53pw@pburton-laptop>
References: <1535002390-21966-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535002390-21966-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0103.namprd06.prod.outlook.com
 (2603:10b6:4:3a::44) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc86810-8384-40a8-049a-08d60d0666ee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:TFDyXi0gWLNE5mMhhuQCQVLaJtjXGG+buLI2fwroYKApsFZX+quXjW6TFd4M8GgLZ6hW3vuqdOsH3P5NxRfgjbvozwxXtkKsr8490n8WBAwD/n0BDUD/2Zsj814ZSF4TpvfED2/D98wijiRRuv92LfKZpLWE4CASkboJMOTp84v8PURFIpNB4sv/TeWI4+L3PVRPppd5HyoKsw1qMyHGyoV6rZEGdexaN6TttFZXNke6flkxxZRKUYDFycJedavV;25:1svN/jAumu5kNRXmKOVL4HmwNNNJLDTULgA3Wq36asFFs3PJMWm9wNQ+Juct0yNz/Wf2+ZqK4mOG/MAbaCg905CIcOlQTqFU3oZ9iixvhG6MtTX+9fP5HlwuGCWBtfCLyK9WpXzsyOeX8E/VaXmr6NlARpIRZegheDbuzADxvWjhWK5btupAuRCUkbYE5mhowAILZAfOaMX8KaF/5Swk6pjrU/6POlttsm/E9xK2+ccTPHmWdq4LsoVjSxC9Vf6L95uZn6ReipSIDQ+M5fjgRnrCVbF6vZWjV+iFmIBZU+3j+2HHimh9MisX0VnnztZLGZYBDSXpdwRFqH5AtSq9zQ==;31:6vR+upXUOKhQi/qvDGaS4XVaBwLiw5EZUlcSpkfdBL7cWWPaDDgzDnv9fPWoXKt4B+UUKYw8anb6+ERxzeoBZTm2jD3x10nixYOGbO4WCJRDH1N9JxpOzEKrWwq4KMvuyIvFd3gAU+psUVui2OfezV77y/aIgbdpOWioBg4XNl8gtUWY4obQLPhQ1ti4TijwBYgcRKz1twcBlLM+z9nJloYzcgDcX6+vTa4zqb5MgWM=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:+MVr2tTYxzTpPNnSsPw2jXWWTjGhmY9jh9LlZekVZn8ELGxLrBmR8f3PRnjom2wlWYO9Y5UYmVMYKSNZ0I/BIZs5sBwRHGQRVEDdTFRrqELugAqCZ7WfJq1pZ6dD/8vZP49vUJemTKXAgDpLKxYW87flNMTIecn6DPGHqSHjJZvht+RHFIN9J7nmDFvmP3Sqw6Qn0zbbVpPB14hGY593xCQRN7rM94niOMtAaaKbAaPRXp61n3LG/HFG5o/Kubae;4:uMipD5y3yJrU/Tml6lHD/+dQM+CdeborHHK4+NATth+IPdK/CvMAZxCBrXFE3/8PbWaIzUjI0OghRXXawSl9TUGC0lvva2Fe7eNFMQMSQP17O9kUaW0GG8SUKteIjIedbsFssMSs+CitDs+xN6MnRwcIL0/C43RSW3kEMdb/rceyOPoek/YBRyeUG7k/E504rDJENpJNPR+ULSxGsTQvPQsgmIeHcY084AfqrDEse1JLUP+j6dtVdr5RnMNL+ObJoF1nnwTTLcvynHpQ+DByxw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932AB0089C7958A742DBBDEC10A0@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(23726003)(54906003)(33896004)(6246003)(305945005)(47776003)(7736002)(6666003)(9686003)(316002)(53936002)(4326008)(39060400002)(6486002)(58126008)(44832011)(33716001)(16586007)(8676002)(14444005)(66066001)(229853002)(6916009)(478600001)(476003)(42882007)(11346002)(486006)(50466002)(446003)(2906002)(3846002)(81156014)(81166006)(105586002)(8936002)(956004)(68736007)(25786009)(6496006)(5660300001)(52116002)(106356001)(1076002)(6116002)(76176011)(97736004)(16526019)(386003)(186003)(26005)(76506005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:gzauUdyT5W8gfB4iTStSvQQfvK82KBCcM9wsAIO1O?=
 =?us-ascii?Q?GYDoqZVIHPgTbBWb3IPOW2/CuILeLhgOgtZ2XyyJtPb+riaLegbFrNqWgp2h?=
 =?us-ascii?Q?Afi7PPhnZYVHoYsvKE46R1f5CLBFe7eOLGUYW0IfCU+sKwTIrqcZReGqDGDX?=
 =?us-ascii?Q?lsIdl0lrsI279YTaKh3FloOsXSL2qGKdtaezowa9+pI+xMeJlJLifdmczF9m?=
 =?us-ascii?Q?HOfhHyVF2yWKLjVZfLNaKUMEi02FnJ1F0bbMrdG6ETnVvbEGKmnjucQYsgwc?=
 =?us-ascii?Q?mTJYTKOkOF3USXF1e+LODU1we7aBicB+pVt/niyGC3IH7zn82yf3vTx0cFVW?=
 =?us-ascii?Q?LMvvGMd3k3RBZvls9MGrPricL2MqAUmcfmCx/BYCfreYlaEop8JBTPKTcXj/?=
 =?us-ascii?Q?Jlah+51FeW/ieYZHrBE1TF+mRvJX7YbAArST1aq+q3j8W7TSbq+1kBMeKf2m?=
 =?us-ascii?Q?M4GJhUJOm1SiCZzPu2wd99jzmB9mMnVwOhPNfje65EP1+pb0WbZOu8mZN2Nw?=
 =?us-ascii?Q?+cjUasJs904Qm8iLMwlBt1VzRZVxwrC7oVkY1G99hFB856OxoPlTexq26sB5?=
 =?us-ascii?Q?rDw5jJnLQ+dOUagUb2leXCTgNI3qm2zb094NaGN8H13qrwBL4Xb40IMVaAij?=
 =?us-ascii?Q?84K6yefcXne12rqGNkQazo11ndrpDOm5B2+APRchD9SMGQcVtPrTItRmq56y?=
 =?us-ascii?Q?buvRJz5aYBbAS+DIJaRbd5Er2mCx9bZpDi3hs/LKa03muDrurtpZqPJ8zBwU?=
 =?us-ascii?Q?tSLr5aNup9yWw/wamgMCy8wbn8xcCjfmEhztV42j9IH3Ug269Eu9V2CbJFQ6?=
 =?us-ascii?Q?sfWd5/1An+QVJU0jSjym6Emr7D83wc6lg3xTMPy4sSntOK6IrFXQ+fUpREPG?=
 =?us-ascii?Q?24bCANLlEqAOCEqyzU33vh5QmOGjStoREW0Gh/Y9xDGVjTbs1g1RdVw/ZSa3?=
 =?us-ascii?Q?gkpaEZLODEOIXeVvgBh26CIBxdpQiwfQ0tpkOw1WLaR5yghdLXe+/2oHCqxE?=
 =?us-ascii?Q?lcZsN6FADRYdikqHbttGCVj8cuFXKT4ZyLjwSO5fCxj5bIdxj1Ano3zZYeC1?=
 =?us-ascii?Q?bzsa7eMbqPIJ5ExBNwGMlHkv0LTdAQjg//O3e9dk+7MeiMXuFxzF0LPVOEk9?=
 =?us-ascii?Q?/X2P4SzLnm87M5oKwygb95FMe+WPM8J9DjhxWGjZXFPZGqeOoRFx4/k/0sMG?=
 =?us-ascii?Q?+eYm1cZfAssUw7cGBeMaMe174qh0xcpLGXmoCR/xIBYfRr4xfJ1h3XoXIGPL?=
 =?us-ascii?Q?8/ISUo3neaaQJfwpNVYwbz6lsx4J01d0hha//Z8nfBphmF2+rrAHvhcY6GTD?=
 =?us-ascii?Q?4lDOGrVXRzJ+C8GggSB69I+7WiA0cvVQM4cqpAhp4pu3cUaRS9ChJ9Cv63Cl?=
 =?us-ascii?Q?Z8Ecw=3D=3D?=
X-Microsoft-Antispam-Message-Info: ryr0Jb///JjVP688Y1Q3AHEyw/z9+8qR0FMVX1uCJEzx9+VHzZEFymEYEtgQjArr4YwVkdJBQzYyGQRQe5EXuc7EHBAoxXBd4BLO9j/g6/QCqO8Z9hBhrKvpzoC9TZcWgqaLcFUQBxBIh9JO00xZ2f8MH8aUjYrakwXNxQqNmauYFZZ/k9KuQpvGU5Fuvj5RO7q8fLTfMqXQkHKiggPML53bsdprH9DYoXogtFGTUp23HtbzN1NRrORXEepFwtNHd+UEmLrm4JF/1xck1KvlMEMyLxvSLF1z+Y1kJCQ9mBih33mg6Vmp8amMCQ/CsP4MvUeADBjxCWct1JjKO3RJUQy/NQKgLImdnK+iFLd1YxE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:ECEXo4H7XicdUOhT/tF9kbaBn2YFlTABL3VIYfUZzRmyUfA8ztInw0b93WMYFiIKrhiwHhgwIVImcqCWO5CsPkfd3aiRCkjOI6GtgeSecNaWDKiSxtetpdtrvTKJ8g4cIuBWQPmQt7cSzgGAah5d5H8xv/3L+tEVJ1hsaLg+lkbPVZjvwgcG0QVM/QFo6hz7uNttxpDq7QM7reAR5LCnrl6+SFXpHaqlPYhyMJam/ekC+t0ZUo5QwLmaZpLGJO/FZkDGW5v184kwP25MFA6H6BRfsE3aILACpcYFLGkreXEczS6azae+xwOT29Kw82L3ihl6n7r2+Ddtf4l4wggZx6TfmKkY5hP55HmLHjDEKMduelOKQgvXsZ+G+h6ZLPmkBcaR7H3MNO2hdF0AT5/8c4V1T07756JZpjsyx3tw2Jx9OchGTUMUKOw3kEo2c59JfOWLxO+b59yAZe0Mbtvc5w==;5:raaXqM257aSoFGebeL0zByzwh1kt63yZbEMRV/2vwdsm6sn3+as0F5PDzfiewQ3M2/yCOlWk3UiqXI4I4M530T1IwL7HeW1JF6grIT3wjOYwQ96Aj1zUJL7DYd/44ueUIIFBBHONZjQDLtST9/9Qcc6xXiRc3inW3n1oW6cx6oU=;7:KjK3pl10SLtyC54WwJKx+hoEQgVKh9Fw1CpBLzCBUfqCNRvyfc39ezFxTN6rnH2xyvfHUIljI3+7yMXcJ0ekYGco6mmTYJ4L2YdIR2Qhpw3N22xELzVItErwrxYTpZ4dPUQ6RFj9wb7fr36aI2uPJ2Qk4icVyAy9vAexG0zUVkeot8Zc2nvj6h9Ba9USJf/Y3vnj2oCNmxBUhKfA108n+mw7STQLMdRCXzmscqsbG5Kw8PPR0CMIRigq6nNZU05a
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 16:50:46.4999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc86810-8384-40a8-049a-08d60d0666ee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65765
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

Hi Huacai,

On Thu, Aug 23, 2018 at 01:33:10PM +0800, Huacai Chen wrote:
> Split the common dma.c which shared by Loongson-2E and Loongson-2F,
> since the code in 'common' directory is assumed be shared by all 64bit
> Loongson platforms (but Loongson-3 doesn't use it now). By the way,
> Loongson-2E and Loongson-2F have already dropped 32bit kernel support,
> so CONFIG_64BIT isn't needed.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/loongson64/common/Makefile     |  1 -
>  arch/mips/loongson64/common/dma.c        | 18 ------------------
>  arch/mips/loongson64/fuloong-2e/Makefile |  2 +-
>  arch/mips/loongson64/fuloong-2e/dma.c    | 12 ++++++++++++
>  arch/mips/loongson64/lemote-2f/Makefile  |  2 +-
>  arch/mips/loongson64/lemote-2f/dma.c     | 14 ++++++++++++++
>  6 files changed, 28 insertions(+), 21 deletions(-)
>  delete mode 100644 arch/mips/loongson64/common/dma.c
>  create mode 100644 arch/mips/loongson64/fuloong-2e/dma.c
>  create mode 100644 arch/mips/loongson64/lemote-2f/dma.c

Thanks - applied to mips-next for 4.20.

Paul
