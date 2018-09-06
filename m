Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 01:21:40 +0200 (CEST)
Received: from mail-eopbgr690121.outbound.protection.outlook.com ([40.107.69.121]:59392
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994644AbeIFXVhOAnwL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 01:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLNZ/CTtH/1RJKcfxmn6N1kmm/4CLi5m91lCLAsKRZA=;
 b=EHlw4ebxEL0DX3b/ZQVbIzLRD0lb/W05/A1z0Y/Cb4/NsaIkyVvaia0rxF+qyw3wN7Kpmn2EBJx3iQJMyXrkwFS13ZD1rGCnq/NJtOhBz0z+suXecBfbki/hUvlmJ5xt8fxi6bjcI7c+obTm3M/EL8OEgU3jjz4CrlDfF7/TIcE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Thu, 6 Sep 2018 23:21:25 +0000
Date:   Thu, 6 Sep 2018 16:21:22 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Message-ID: <20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
 <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
 <5B91A8D1.4060206@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B91A8D1.4060206@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:4:16::34) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42318310-085b-40e8-ca50-08d6144f773d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:TSHRRNpPI3GOT/6cVzf25GymBcpLcPmqQpMeuwJjPU/SRWL5szIewF7B1BlwO2HbpBPViauMzJoxd07KzubOgGZCGLXgm9TlXGgIGBXC2NTrR2vqwTcoe/elDJ1Wj7VaowAkJj2HoIqmzU4B1oVY69iV+vxboemEStURnmQat1iPJAMXPN7zBTILTYDFLA/fQyBexdQ0RCrrJSbSA+Wrv88lcVgo6PIODY/0IaS698dVowpL6IXmNCr/gV06agvI;25:xC3ohIEIj2mERyVJSaEgIyaXDP9j91eIFkDZGzYqF2Yln/Od61rn33iCimXWljqM2JMKCSNJ0r4jvmqi0rZN01t8CVZ60e3N/96kZOt7ZUk/PraPNzyXLShT+PX5asajKKuARyJ0330NZ5YOLdaFv90PapCzzijc0POr0v9kbiZCsG025IgBIaq6+w7A9G0iGzf+JRWBxt56ItT91wr2wpuUxas6A2GnwxdPGmMbyCtj8zzOyEYGwaIK32lGuPVQbUoyp1zcx9awAme1nmiixY4BdQU8nftQbufCoQ9laQYpK74mzkGOrNXLYa4AbqqY5dAmyT3WWK4uy6V8vYd2kQ==;31:6ajVMR/rxR7UuJkxDtkVJjyv6Ei+zYPltFxAg+keay+J9lDC8o5y6z0pJWAdLtM/IX/ypaUqsjdEgMyXOgcWxYoeZNl45y9ZRXuOTyhbfHjFbTwSYbjCB0FWetlkIW8QRdbJ8qczjBpgp6c8ai1eIStUxAG4kNv2VNK45z4Nmhd6axWx2bXEPaycrd38lqgochVgoewGChFRviKXi4MrkL1TtarO7o7rHzwoEmvFqEc=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:ZVydl+yk18r1Y6fyIVRTe2002nWso31j3SnFeNsO9k3sfOkXstO220HqDOAFm8U5TrJYyMKKEdE57tnAD0EhjGm5i3Kq8CR7iagkif8/2bfnPMSQDAVnx9gU0kryGPKCbfQ30qd/tkO+X7gMHqK/3UytVOmIuLXmeAZM/wafkuFPRQae7wFqhIZsF9KPOyifATyt5mTkHM6v6o1XnT6JNzK4x59934e2o//JGoADS/uThI0krjm/f6CmE7Pp2+hN;4:SnBkBL0yhiGOiKgw2bJvIjCR3hn1pfeCHXKNCiIH8SoX41mfrzCWtKCul9He/FJPaCsUBlBjTikzJJYv5+2dmIHsQKG12VoL0jR9O2CyIp7f4TXZsBXldAt82yBkeNT2wYX6oiPpAPNvjsZgQbyNdgSU7U0qydYn+mX7qVuxiOflOnD11O/90nGd6PuB3AkVMiJBVvOscuVLsJ8P2WT90pI7x9q3dbekEDPRmVKvdcVRkstAEFjTbbAQp03jjeo6a4Fp3ivqJgyZm3gkCLZSmxUFgw8hWMjM+pObmIh/gGyq87aH4vYoR/nzBvwyGiog
X-Microsoft-Antispam-PRVS: <BYAPR08MB493485AC5728B9FDA01361C7C1010@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(376002)(346002)(39850400004)(136003)(396003)(189003)(199004)(81166006)(386003)(52116002)(5660300001)(76176011)(8936002)(33716001)(6116002)(3846002)(6486002)(42882007)(33896004)(6246003)(6862004)(6496006)(23726003)(93886005)(2906002)(68736007)(106356001)(105586002)(16526019)(4326008)(1076002)(50466002)(44832011)(53936002)(76506005)(81156014)(316002)(8676002)(486006)(478600001)(25786009)(26005)(16586007)(956004)(11346002)(6666003)(229853002)(7736002)(305945005)(9686003)(97736004)(446003)(476003)(66066001)(58126008)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:jvHwWRb8j/5lazoWwzpJwEZ2bM2lbkMjy4bxvSoOi?=
 =?us-ascii?Q?C2axnurESYeKhTYvMy9/lWfp22bgvW9+ywHrodaVtv1MMBOTPmnkKjDcxjZ3?=
 =?us-ascii?Q?WZOOteBSXnri8s4Md0zi0TAmAd4r42Bk3GNZjEerDWi/u0JGq2FIiwySeDjq?=
 =?us-ascii?Q?iuvYiuw/Wku1RWjKvZADs9cejYzMyHeP5bpLUD56wWWtW0nZ7Xs24LEgT0Ol?=
 =?us-ascii?Q?vdfGepgAsDnBOwof7OCV9bMx77AwHQZUXVR0eW7GiIU0DeERQCIg0DngAgyV?=
 =?us-ascii?Q?u33GOjHIvlKoVEjKv21xrxriNyjJeUlwFsybg9ZAsmD/3LPkC5YE6odSKrG8?=
 =?us-ascii?Q?jha/1T1JzbkgJ4P+6G/U4Qe1LOqjRKGr+O4axDSHhlUKDNskaoB16MPZltEy?=
 =?us-ascii?Q?fvHCJA2eUaYSTP8Cu30nXWZOLtfiL9pOEvKEefNQGaVBwkSEzpgDMncj55/Z?=
 =?us-ascii?Q?frQ5XD7O/VT7KdavBXivhzP5US0m/e9R3jShi5om1rA8LzhdBj+2eMF0nRSL?=
 =?us-ascii?Q?QlMO9v1EIZFdAGxIMgRuP/S7iZReF0zV0It2yYArHKafJU0RHHb1swtOOlfM?=
 =?us-ascii?Q?jAAheXVE99f4eW3CIGgjCbrWfCsiJNBaIwYDB3+Da9Jw9GCvsRSMgok0V4n8?=
 =?us-ascii?Q?yskCXyz2p3PtoH0SGa9WpLbiSTMXYkh5VKBNlKNuXFdjYN3O4OfqRoC9hOjx?=
 =?us-ascii?Q?doLmj/zk20DsH/BAyaiZm8f+PZkoU79zThzIVszfRyYUTZjwyd4edhmSCtUJ?=
 =?us-ascii?Q?HQYs6sN4heXasXTnkVrg7uRZ7WDj3bsepb6xl1P7UDCphofkKHj7lfAEuJ6F?=
 =?us-ascii?Q?8Ys4f9Wxt6pxxVAGupnXN4Ubnov8U6uRLSEdt2JdPtwfZL/NwxCG1noaC4r6?=
 =?us-ascii?Q?3Q/fOk/m+UGJHeIEI9QoCaQR8MoOhcZFzVovzSAyUppgcCqYVKqA73kL/YSq?=
 =?us-ascii?Q?sx18zDiub9cf3tLM5x0jrbD4bkstS4cOEBIzamW8/q8sBfeXYlNsPrUkCGip?=
 =?us-ascii?Q?4olpD1ddHU7GTt405BRr5gsJ1KnXc8cIiS1sDs1BOx/J+Wakao36RUJPwEL9?=
 =?us-ascii?Q?HgSJ8tS288mQhLC9oarH9xRISYlemmNlXKNlVeatbteRcB9CvTN2Y/9r6rMm?=
 =?us-ascii?Q?StFW6pNZibIejw2h6tsls2x8wJrQXGVzTUa3tPeeHTyCHMsg/cz1MV89ZKHO?=
 =?us-ascii?Q?WWhdkVziwkaF8KJTxXf2Qy4vrdCUiwK7XtWTOUW63S50jaYCse9nEaM8LfXO?=
 =?us-ascii?Q?LG269UYj14Fv8oFDq3EHeLUKhg3yyDjBf4RsgqKwh3SX96JQfC0bjIx2HDNs?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: ikL/8HOTU4ZI2LFQ/vZgNDpKOt+OBQ5Q1zpqkcxWNFVcIi0SreXd65jRnjRBKj7AXvdPQPK/gZO4X31qH3TcnQQew+5c71dOAh0CAei+uJ1ncjRH7Yat8Xxge3LcXJ+iHFIG76GJJQGvxrFWV42C5oVonS0ek3piDsfnSPgyJk+xdKd01Bifr/LlmMaFTm1+0rMpJDBg6Lnenhhbs35v9HXWNyP2H3FvxT+c+pk2LkymIaA/Bn+/HVvdg/6R5DEvlRT/ql2EUFs3W9Yn4bd054knzcZWo4nr/EqbspiDVRMMlvySJXlSbvyVQfnShX1HvzPSLKiD/0F1BqbU1dxWRbW6zQPfXv9+zWrPS1sMVVM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:sDaNa9TaFTTtfh7InB4LHXQPOdIqzRHdalOBZFcUGrSitoxzUG0c1ZLclPhMBxSMTQrv0DjznCp/AdnhkmI+KvYI1J8CiGM4Rjh3keji/hVfLtxx7rAU1gegpCn68zMZdSnms7KNSwCm2kwXhnfqo6AB6ZRIl/WySojQNQIkHNZ/pDABjrSIQ663RmDrqcteUC8gw/sChWISsoZRJp+87dJRew9h8aBohvjRQZaKM8lKD1BTdwPJBI7c7U7f6zvvZQTPSLOPuZsRMoxTULGOiNxsvEnSHzj/l2fBOv87gklll8OiJaU+fkN/3SZdvgtFiHynOB/CZ39t8aN6JMuTyKO0PtZqaV++N12EoS6QOwP+IzI7ZFGEAprHtuZM4bjpLhvkj510IwsPmDl0TgrII+YmfG5KcA/LkJHp3GUkDQKq+qth9klkq/phK0HBt0GuPFqiy20z6vfjOAx0BRAL9w==;5:XOyORFB0sOtxnmeKPnj7Tex7Jvxzeb5ByqTVYtje8GtW0iqX+dbZcB75/MtaLlWCXAMu2pVJrPhvZ4jxYwfQ5zdwbcVUSTbaXSROwhPCO3V2/lSRMiHskUOWFGVvnUX/GMXtsvhSkQgKzlMCWxeFn9zgGmol3fiOYCNlYi5p+0k=;7:a8ZClHVN1ebW5iVN28IJChRwGQ0xeTxvcDjxK22U9OlnwNow6JcNNVhyqbOPBGwjwOE1Yvns6iSAwOCE7TZcrWOpOJasXvIokLsJtd0R3sRDX+qskmDZm2ilfL1oZ2OJsgLC/rusdjzIORPa/vsCWARvOEkVYz2r9bNIeVcaHA+CvqQnuq1vi31t1tJy4II/0ix80S1bsT34ARuE/xXUGxlL6adAtbEkkTT6MiPuhyPi2quNjGsuvxLJfpKeQeDR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 23:21:25.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42318310-085b-40e8-ca50-08d6144f773d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66121
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

On Thu, Sep 06, 2018 at 03:23:13PM -0700, Dengcheng Zhu wrote:
> Regarding cache flushing in machine_kexec(), I recommend simply removing
> __flush_cache_all() as CPU0 will do local icache flush before jumping to
> reboot_code_buffer, and other CPUs don't jump at all.

Unfortunately that doesn't work - what if CPU 1 runs machine_kexec() &
writes to reboot_code_buffer, then CPU 0 fetches stale/garbage code from
L2 into its icache?

The icache flush I added in kexec_this_cpu() isn't enough in all systems
unless the CPU that wrote the code writes it back far enough for a
remote CPU to observe. The existing __flush_cache_all() is one
heavy-handed way to achieve that.

> Re: marking CPU offline in kexec_this_cpu(), it's probably good NOT doing
> it either, as the system is going to reboot from CPU0 soon.

...but the new kernel will have no knowledge of whether the old kernel
had CPUs marked online or offline, so I don't follow the argument?

Marking CPUs offline does have the advantage that we won't try to IPI
them. This just makes perfect sense to me, and note that both arch/arm &
arch/x86 offline CPUs during kexec too (I *really* like the way arch/arm
just uses disable_nonboot_cpus() to go through the usual hotplug
sequence in the non-crash case).

> HALT is good enough, no need to gate core power.
> As to whether it's safe running play_dead() in parallel, it shouldn't
> be a problem, as the loop is based
> on cpu online mask (which we don't mark offline as mentioned above) -- The
> CPU will simply halt itself. For non-MT CPUs, play_dead() does make sense
> as well, as it's supposed to stop this CPU's execution, getting ready to
> reboot from CPU0.

That feels like relying on play_dead() accidentally working rather than
doing something it's designed for though, and it would come at the
expense of not marking CPUs offline & the associated fragility of
needing to avoid anything that might IPI them (like some cache flush
functions, as we've seen). I'd much rather we figure out a way to do
this without all that.

One option might be to add something like arch/x86's stop_other_cpus &
crash_stop_other_cpus callbacks in struct plat_smp_ops, which we can
then implement as appropriate. We'd hopefully still reuse some of the
code from play_dead() implementations, but have the separation to allow
them to function differently where needed (eg. the new callbacks could
halt all threads in MT systems without caring about cpu_online_mask).

This would also give us a natural way to check whether a system actually
supports kexec properly, as we could just return with an error from
machine_kexec_prepare() if the stop_other_cpus callback isn't
implemented for the system (ie. is NULL).

Thanks,
    Paul
