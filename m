Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:37:44 +0200 (CEST)
Received: from mail-co1nam05on0710.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::710]:16141
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXXhk7BWYJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 01:37:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a0Cp8ntHbEzDvC+QEU57eiCQtMVQl86eOr1PkOyEXU=;
 b=X5Dkw1FmhiRtwzjjHEKtxIgIzC8TWxea18oU0rynpkShJfEyzo/eXIr2WVUSZOPCn3GAXyFdXnZTedvKD8vQS9vtNsTjmp6oyM13FhJx/eZ45s+SSvoXginR6sRB+Bp1OydXdeUmvYMvDNq8zFuFU+Ts37bAqPB1TES1IZPUnbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 23:36:56 +0000
Date:   Tue, 24 Jul 2018 16:36:53 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v3 6/6] MIPS: kexec: Use prepare method from generic
 platform as default option
Message-ID: <20180724233653.lv3rkz7g33hqz53m@pburton-laptop>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
 <1532357299-8063-7-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532357299-8063-7-git-send-email-dzhu@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR19CA0076.namprd19.prod.outlook.com
 (2603:10b6:320:1f::14) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6d8afb-5a5d-469e-ee07-08d5f1be585c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:5AvOvvsT/fAw2JDNMwm7sPcDHvtzwNxYwyHSyohpWpZSuJivel95/GztVDXNYIh8jcYHgwhVhdNELs0uzNSe4+8hzEG4N5u0NSj0+OtNkWD/xpVuSiweOtYteqDGQVcA+f3k9DZ1jVFGACCypnm+fMMI52QE8dMpdqCX+ZgWB4Yw+AHfgIDkX6faKJY9iQcmsuN+Lpi1hM7TV0Jm/zQaSHYedUxHglCU5MtYuAWV4tO+ldWbJ3mvgNTNJj/DcB0q;25:UeKS173SNPqWufHfsTYl1ut3YZlIaC5WKe7yufZyjSwZzf+5cd0SaSfTRz6/egB2hNcSIv1tS5qd+s403KEq96O1hAtN0j1pSH+9z3eNXk97Ui2zWVAAy158WTxzyaJJOyKI8JKXfNQTlUc6FYN7i3B8zUbPNScHssFUe0GnaAkOznitkTY+2yizp1fCFG+VuwTpHwd0qMbqXBoUHR2kIx4LIpMKHkvzCLnvbwnA+kaPqn0VC3nPsz+497xvbshD+SBVPlJZOSBRmLTKMG27CFSIW74vdmER4rCYo2dcf54MBK2Q+oW592z6XYJyLkSzt82wVQWsYBVAdfdTpv2OZA==;31:sT7HKNnhXwDOHyNWIWOhNW/PyX9f/5JmM12QY6J5Wo12RG/zNgEPnTrPGujWf3/DOt2oYWDItOVN4EvDT53VZdZAIgtp3SFbXq3eaA4xKHiX+M+MJU4rpfYIxtmSi5Y9jBn93EqkPlOS3pC42+vg9yAIyvmB2lcdGjYkfQYB/fUmazkPq028h1StoyhNN9ZUrFidlwwRqq/wfTQStfkqnILHkl+kJXQ3biCb3L3S0oo=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:Eo/FGS7PkL1FEAPL0BUlmNoNdK+SUhPPuOxkn2LS/BhB2vvKQwCe+u5pjbz0I29rJgG+XScQ+/x9WBBsn+1VqJjimr+wsg0dZuGd5hghkQwnvpM8cJFKHp4yLN1Ni8kVVfzouG72bwZY21fewz9vd5AsN3wrhRIS35NB9piiabNHVVB3ukKcE3Mn/5jFW55vAsQjdONWm2zMzSa9DE/9BKZEztB+DLa0Bv/4I01zS12txSNV7LBISFouPssMVcNb;4:GBrZs4zles6eNdzzOfH6OEWoQ/mJhAuJy6R3PGR/+ydgpEoYTHRD6lrDAOnqXJET15akk5Qk+y96CRlwAMnenC94NZT3r/2I6cY0ZQSOal7KHkBr7Hh18fN7Asflf7ZdLx8p8JyWSLum/C8aiesB9ADwfrJVuNQEehr38RtNHhhHBZaouhc+fgpydPbXG97iYJ71YeUD1tU7oP8NR4RguGGSo+uWY9oP9voPPPIJi7pQBAskQbERcV/D8MnI1eoSuNPK4PGQBsfRttN7MdQd9w==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4938B625FB07E1B1A3C7BFBEC1550@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(376002)(346002)(136003)(39840400004)(366004)(199004)(189003)(47776003)(58126008)(966005)(386003)(33896004)(76176011)(33716001)(42882007)(50466002)(11346002)(446003)(16586007)(26005)(4326008)(316002)(16526019)(6666003)(6116002)(52116002)(6496006)(3846002)(66066001)(2906002)(486006)(956004)(44832011)(1076002)(105586002)(476003)(5660300001)(23726003)(8936002)(76506005)(106356001)(305945005)(8676002)(81156014)(7736002)(97736004)(478600001)(25786009)(81166006)(53936002)(229853002)(6862004)(6246003)(9686003)(6306002)(68736007)(6486002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:nCjhUy6hzUHyuAy6W3f2CjrI647ES/hOYno+vVWW0?=
 =?us-ascii?Q?dlb5o4nAyhuWSz1g6xCMHvZMEhCXQJvtZV6HtzAXKDiQ2aJgtajvPMRFoYUC?=
 =?us-ascii?Q?7Fd04XEITcAAgCBg5CoF2nntg0gAv7el94V96JterpASuAPPzKmcwE7O1YHP?=
 =?us-ascii?Q?HNo1ekugZXHdEKDtDdnjISg5kajZ8kdxY0rh+zHDx8/fn6FFbSbdmaFaflwR?=
 =?us-ascii?Q?2OG9FDazSwU2eEqTfVj3rSWtTsih1xcdHx3RncjeU1BqbaI79TwGoMDuLUC3?=
 =?us-ascii?Q?5WVaDTlJ6BznNubGFNm0nfOc3pGflpyQVSri0QtVSt1/681dZhTB1w2eVq53?=
 =?us-ascii?Q?nn8O6qt9kZmhsCNoeWbf6Vz2agymnWD9bNcoTeRoJCU7avzEbEZ8UWsqbsOm?=
 =?us-ascii?Q?ycIf1DuxxDI/Vgyj13iGgMwxIDxD42xbtMjkRLPC5XaqeCyJyFbhfRlK6e7D?=
 =?us-ascii?Q?czgRHIVKtZBBLToMB5z4pX6oxr79b/soB+eGEg8zQQdOD6rUWPCEzAAV3E+I?=
 =?us-ascii?Q?V5+DfWsJxnVPQe4Ac2chyjyT3wOMAHpM+xsS8y/RatHOo3WMMay40QXkMrxk?=
 =?us-ascii?Q?+N/j07jDGUYKMMpVzFPooCPbhLUaAZ1XqDVa9Wb3VJB+k64VU69t+vMfueVz?=
 =?us-ascii?Q?CWBcN0r7qCIetrPlc16qbRCIEYIQDCPiYYdFm+fZ4UhP3k+I7ayJix3FJ8Jb?=
 =?us-ascii?Q?HEmWh/jQlo6CYXQhSw9k1I/XiNDiW7w/jQVlfnDaVQ9udRX9C5szHL8mZyFD?=
 =?us-ascii?Q?52CoXCSKzUwGKXY65pOrZJiFzD1cvNR59M6ugHbXRq6djm8QZLyikRl3LBxs?=
 =?us-ascii?Q?MVU+AphafQhY6pNT7kyXYK8L1OYV/HdNB4pLtf1VxqDyYvOYMlJ9zZ3o40gh?=
 =?us-ascii?Q?nI7g5hf0L2lAvkXbfgFlO3HXuM1PEHSVlh9JBDKMXv4SSMHaOQ4Z/SgTmaqE?=
 =?us-ascii?Q?Su6GXoTKe/MK8bIT9jHQBDMpaRrMyMLb0og0mhfBau1UwsZshR/4wjhQipga?=
 =?us-ascii?Q?OL1WLxQ9rkgNPMFIyKq/Seb3XqbREticlZUq2y7hburszNUMAIQYK1P18rHy?=
 =?us-ascii?Q?jeY9YhatraWvxrIg8x7CLfIzwyybr8LsLghWgzx+f57UZNQ5L8kBDEALVPW5?=
 =?us-ascii?Q?ZHvL4UOZ8b4tI96Sn/Vf2zivq248pgraucSllCEpfIkONvip+0+oVUY5XbsU?=
 =?us-ascii?Q?0kExTxXv6/UgxDNoAWyaTCSZlHaie2gFkvOmf9eROb4esvppEWncAvn0M+M1?=
 =?us-ascii?Q?UAyD+nocC+p7GihRN1/VXAaoAs7MpPx2wkllsMIVV6PxvqU5lKbGmeoj1KtA?=
 =?us-ascii?Q?gPjrhz9tU6FG+9f/EreoxvwlsjNyfrIZT0Kf0Zx4hst?=
X-Microsoft-Antispam-Message-Info: L4cN7kTPaMCarpLJqz4gxAOb2RYcpw6NZK0+47YYUTfRfQBIq9AYc8UiLBjM6CI0T0dQ+Fx3WZ0aW6MtxiYIIsHUXF1Aze9Gp3IVxXxLIol9z4cBeWZ/CnnufTN0mx/J9r9rkCYomR9kebF4yPwUWEP00YJCqe0uKoYpxhQWN/mPhpXSO7RX2xtV3Nvc8aPIZQpGYpgwHgbNmDjxLhcGpVSwtK+QoNliUd2bVa820KOgI3Z6o/TPK/GnhB7ElHMfQg7A5JjiBL+HMi8pIXT5wtFOUxuGw5sWQ2v8B0og0iYnlpTSWCfaVhfgD+o/uXa+SqPYSV6wfR1XSISe9+qA0tUHLlSEbsyCIHrhhPLvmVE=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:3U0VJJodW6KC4yCnZYGzeVg6Lw8LldT/2dmAoJqHDW5pK94fcdbWldH5b6MkhRRNr0Mxiv+Pj3xjkoh44ZqdfGOHqOrvgt0gT3InULARAnxJANU1CXC/itGNKgx2+anUxD94B7R9mJ3SYDWQHKoRf1AmSTCbgaT3j2mJLtRFUtXyg1AStndpHOdshjJ1hsSomxyLgc/kuJmHzz8aiC9d8U3jZJpxQI2mdf4LJdXcoXXeCN+3Ard6VwsJEzcIDQAl7b9n9T3KIgls89vM/eyYZgchW7IhnOUFMaRFWlAF+qqOoXVdrTni+k+Xj9zwvPs5irBJgNRxOpMubFCMdYoG2+mtyII/jWqd5jXGVWVMessMwY3B5bua9F1LzrGpPRFcuY4lcNTy5sZFTzz1YrkxNstniCfX6ErDJikwa7WHcE4/8Mv6fp1+ncYH1tkjNgrZrQkaaNdhkfniS0S/BOSBWQ==;5:OXtvGwqwOGsQ3sSup9kF3LaQTCS9VxrdDOI8Jbz1AmSN56K4z+O67j9MY0X7ES6aUOZ1sh1F+yvyfaA7zgho/VFjoANHG2LsCAomM5fvQxiJO/n8a5pxiBeYwghSpKcXaqCNcyn6u0f7+oH5SppnStofIZ4ZnQWGliHDkShEDj8=;7:O5fbrjj+wdNmJh5v5h0fDIXSYeG75zZ6C6k5XtKnXHq+ivGnXdgUm75QvpKhc7xSVpZgorkfmTzION3zbXPiTxpeN75y8zZi+lbWH748A6IMgmHbOEk0zKdLMrrQKlsrepD/w5+L1vyWedpDzy+9ljwPk9F6MfuSULQF2splziPGLT3+eaES1ky+HrWs8KzJpoAom1fA1ylb60NfdFs+yr2/8v/EpJnX0tJSycL0hF4zV/tElA3C2/2ZAheytmND
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 23:36:56.9640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d8afb-5a5d-469e-ee07-08d5f1be585c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65123
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

Hi Dengcheng,

On Mon, Jul 23, 2018 at 07:48:19AM -0700, Dengcheng Zhu wrote:
> The kexec_prepare method for the generic platform should be applicable to
> other platforms.

...only for platforms which use the UHI boot protocol, which is what
generic_kexec_prepare() sets up kexec_args for. On any platforms which
don't use this boot protocol the new kernel wound find unexpected
arguments & in the worst case do something crazy with them.

> For those otherwise, like Octeon, they will use their own
> _machine_kexec_prepare().
> 
> Without the default prepare work, platforms other than the generic one will
> not be able to automatically set up command line correctly for the new
> kernel.

So even with this patch they still can't unless they happen to use the
UHI boot protocol.

If we ever have multiple in-tree platforms which make use of the UHI
boot protocol & want to use kexec then I'd be fine with us moving
generic_kexec_prepare() & renaming it something like uhi_kexec_prepare()
but I prefer that we don't just presume the boot protocol for any
platform that doesn't set _machine_kexec_prepare.

Hopefully anyone using the UHI boot protocol is doing so because they
want to fit in with the generic kernel platform so this won't happen
anyway (just need to get EVA supported by the generic platform & then
there'd be no reason at all not to use it).

Interestingly there's a patch in patchwork from last year which aimed at
making the default to pass arguments the current kernel was given to the
new kernel [1]. That would seem like a saner default since we'd be
making no presumptions about what those arguments should actually be,
but I don't think that's safe either because if any of those arguments
are pointers we have no guarantees that we haven't overwritten the
memory they're pointing at.

Thanks,
    Paul

[1] https://patchwork.linux-mips.org/patch/15397/
