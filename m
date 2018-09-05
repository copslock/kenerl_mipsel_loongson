Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 00:55:12 +0200 (CEST)
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:52144
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994635AbeIEWzIkwxIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 00:55:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpXuJdAClI7DlkzntHvv5VCrtMdoNYGZN0JLidN9pKE=;
 b=Xjhqc92Rmzv2IkwPSVNhPFeEcrDhnUIY9qoFE0mFQ1D7aLgI6NACNJb/03b3WuXSqwHnYuEFaA9WHolRITKFCOU+mbVWxqvmvJprUcCtsSUbHY1LtB+CWXfn3nUTC7elaFGdDBJbCD3dmZGS6su22o+gGE06cv/li4mtiH8t5P8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 22:54:58 +0000
Date:   Wed, 5 Sep 2018 15:54:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Message-ID: <20180905225455.luh32536uei5je6m@pburton-laptop>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905155909.30454-1-dzhu@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d6b94a-2d62-4d56-66eb-08d613829b0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:1dKv96mv8sNdiHR8uYBrUopY8s1EWb3euVrRC9r0Zxf5/zyldOLNhFo7WY+HR6j6/HL87Uqp/JWcdi3Q1vqeBdAA7ZgGcDAU8a4EedHdo1Xtxw5d90ereC6gKyxvcz8btRxcdDpgHIGAIoTxZW/xrQE+lYqbqRcNFd7u2emVRAqptVEuQllT322qcLRXyzZkqRR9LYy+AGrUAnrkaAE9FJMrOgiqs6MQse8N5mR4JBmodVUcDBndtLgrjkepzxPd;25:vlP0o+kNOhEulNBo2J6SwxJLliDKvI/oqDlG2BxZvjpGHsMjYE/ALvXUeOgmccMN9MU7R2OtxJtM/QjXavVERQTyIcQN8X7sYXubMJw3eWVfg71Nx6Bf79GTdyiUCOj3DV7MpWB22sU4gca4ri3NWVsBBqwe4x6kk3i7sD0zXJfiVWXtGV3fpIojirDIbMno+q/l8/H3Wg1y6M9cc0vmm8l5xNLnpv5LA/Rwv6ymRbWFEVcp2fhhe0TYkx7LvyA8P4Efti9EEXwfUI6VbLaayahavc9lGHzMuRi1S8M3RE45Rt/SFQRvJut3E0bp/2pMaQLnJWHPOD+PuPQnQ4/egw==;31:rDPjkLkbtgK8tb2WaLcmGCpw3EwNTCbCSdDI35Cl72ZZW7/GorVVXYdzhq25OfVE0FoPGrJ7hEqyXu5y+ch4qtPdX3nsh1RwRvRdRO7Pgf9rrkub09ohvEkss1psMO3c77Y6Ty/+l6Gka1OjzMANbcFQw8gfMqaHYG5HUqTmgIG/NWepLXobDcLxxqhZom1JRbTe3C5yf69vKI40cOj/+06TOPD46Od5pmAv95NsBNs=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:Cie/bctHAQip5XeXHHQmdust3Hm5bFw/mulv/jXd2nOuQCAQFxm+VLYPKxTLO8w1dRtoEb400PTnhQxoiXjAmLlx6mZF45YItT/6jKSgwqcgnu4+gXlQJLFJVSyj9uFo2+nT9oxBB6OJ/d00t4BSAErrqiR37+uqc5FbUTCk8yCM+Eb7zBkiheNZgi7O5PE07cfcjG6LkDtuWOU046qaoY9ywQh5uzRG3jnvbyuoN4vgIErWAT9IFGlSTej71BEs;4:4wjfwbDQLmJrhyHGaCElEMNEYMRiRNr3gMrFqsXt+Pm/qjmH2AMKQptZPU97MAjvWAD27jTvaJGL2fTPD0vRkZ1SNgJO55sQoQLi6LpG0M/Bb8XRAu7BxJPZVL+la5UoIckS0U1o+M5DB5Gnb8QbvNOzhNtjfQic9bVRFLBIPYBthxAQnV+fa2d7VaGggSUacB+f+L9HsLtE2U3zYflE4cJ2e5Q03mD1cQeq4gzBcnrhKvy2X0Ni6u8+9bAaaxMy97wsuuJR23OAz8cAITLHlUc9E8Scu2uL7LLYUED6XbxMNkuGweCqgxZQ85yXlt/X
X-Microsoft-Antispam-PRVS: <BYAPR08MB493497D27C4505ACAD6EAFC1C1020@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(346002)(39840400004)(136003)(396003)(43544003)(199004)(189003)(81166006)(76176011)(52116002)(966005)(8936002)(33716001)(5660300001)(386003)(6116002)(42882007)(3846002)(6486002)(6862004)(23726003)(6246003)(33896004)(26005)(68736007)(2906002)(105586002)(16526019)(4326008)(106356001)(25786009)(446003)(1076002)(6496006)(11346002)(956004)(44832011)(53936002)(76506005)(81156014)(316002)(486006)(8676002)(478600001)(16586007)(50466002)(6666003)(229853002)(6306002)(305945005)(97736004)(9686003)(7736002)(66066001)(14444005)(58126008)(47776003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:4rZMULbuQnPcu4bI+Z1DXtCm3PlQXj1e3kaoOSKBd?=
 =?us-ascii?Q?ftGXW7ksUXdFn+pSe/aLa2U6u4COeV86sIcsUQ+AWUw5ORljafOp8svKWfcl?=
 =?us-ascii?Q?PDMMtf0CU0LbYjDvj/RfcreiLmqJ+/5r2sVYewfdwx2mmPw9hn2QcKltHXpA?=
 =?us-ascii?Q?u8QahV6UCJYOSl6hO3yeI0tfQmHXOTLwC5ZbThK3y2G2b7pceuIxewSYIkUS?=
 =?us-ascii?Q?S8xR2JlpgdPyAw8YzNh0BuJDS7CIjLCAq4M+kNR+e0h7mnS47CwkpC8ND+N/?=
 =?us-ascii?Q?ZtWUEgupY5gu/Nn5X2Oo4sEU7cVWOZrKdO38cR15DluzHD7FrOYYrWvMF/wg?=
 =?us-ascii?Q?nuzhdgzwkQm+CzD0xpQGhGiQ4lmNxBf4tiymBoUT/XBTtrlx2G0nLbIQMHP5?=
 =?us-ascii?Q?t9wAcgZVRZHhch6s98cWNoRN8FtnvmnfgVR37UsgFIYpepxoyMONSZg4LJlg?=
 =?us-ascii?Q?Ad2VXhY70ycwsFNanIz5cJCqxGCmITFJOnVr9fXW7vhFSs4ThCGTOwF65eH+?=
 =?us-ascii?Q?dRhKqO125GHoS/ziOdqsB4mrjKPFwbfgfvulmNtiUJPyGFs2olVdZtjQv9eS?=
 =?us-ascii?Q?GVsz7ymMOarUfbG8FFizIjYwu6ppsXDDkSsZzLVQB/ZPX43FS5JopEM/xIwm?=
 =?us-ascii?Q?gXTyT//ymW/dDbE0aG0gMDyVBqITNHVOTs3L7UNlustJssFF+6nKLjsivnPv?=
 =?us-ascii?Q?WavouknTljIdAeWUe3XcPAb2U3s6RaHBMMsvDCJOA+LWEEZUeD5J4MXJsO25?=
 =?us-ascii?Q?Q+/6WDoN31QLnKQKrRx1dxCyFzrjggMAJbT1yJ/VcEs9mqN31RQC+egGpv8/?=
 =?us-ascii?Q?GeeZxaOAoUyZMvG9EmQHyAbxrMsG+lGvZrJ7FoBsVlyCG9n2rcgiRU0j7Ttm?=
 =?us-ascii?Q?/TLROXl1p5aJ3ll9UkPslO5Q8IeLj4/SDSyj3U+fMmutzH7Zu9YOiYlKctZo?=
 =?us-ascii?Q?IwWAj41A3v33purY2L0LhOQE91VYGRNW/F6fAesXMILlEIKLe8I5VKmI4pka?=
 =?us-ascii?Q?yaqVQlQW9hEJCXGJDfDcvOX/BUkCQ9hf9wZMUphSUJ5FTGODABGwFHoFZIty?=
 =?us-ascii?Q?ko6RU/vQ48KNvTlqZlfY6yB4ONBtNEZpPceciHtNWvC8WdCzRBSy+1OWB1X6?=
 =?us-ascii?Q?jYKMTI3EO/Sr78BRvmOAnd8QSQyy3lqgufCOcnUk8RwMrNb33ZxdKtY2PwME?=
 =?us-ascii?Q?D+bqrWz7fgRz2ayiVTF7/8B8RbPKqECzItfmQKeQYwAu6GOdqbkJpN+66IBz?=
 =?us-ascii?Q?SIxFjqGzoj+iMk5TUNy+F/F5rMGItzY811EZDhJE5YHXGJzsCZh9VHSsz8di?=
 =?us-ascii?Q?OhHzM2kKWZPy+9xM3qfxq0zizZon5MOWSaoB5C0kBpsQRNGbtX+c5idnXRRR?=
 =?us-ascii?Q?YTcSQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: xUehlb9tamozJ8u5dOAEfcwyWsAMYCpBf2yO57vSJU+6gShB++uMmEWqn9CeEYpqzFkfmLFa98/Zd6O9DIdJnkbu95kjoOoVD+iLyj/9fCFsbdSQT7r1brwsFyU2WiStw4ROibq1ze/Klx5ybki6FxasSD4UnczOvnxejjaHOSDqYH0uBQqtsnEmV13QF/mtTVALLXuDJ8HY4EMFV/XDyZ8N5uneob4ywcOza9usJMvQuFJzfMefi11jO2nlEpZjSqrSR0P14SBMDjilazvjEM2IpbmymbWK6SxdobOW5fX0banAFMI3hBzzypHPC1YuV3jduge3KfeqhcGXHSRkzAwEQ+ZgvkPRWj+INu573oM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:P+rbObd6jQarZxFQ1sC3Oykif6Coi5a+Tm9hgqHOlpsOqokPlzpXOj6iEWWfMIxR2Mip1z8MYY8XOWcrOS3f/wW9mkQ/EjJUkLQlba5DKsYRFh1GIkNMTWvCKS3hB+Kkg1mFfSKo28q8SI2Mkt/Y3yYIJSfVudOLz0g7V1xSncxkWR6CXe47szOe132kBDONWbIwwUqfBQ/sf1UNRk3hkG8q/eE0ja549wAwiVkB2VIG9J0S4DZHu7Q8tbEEQ9imABV59HAA791WfZVl+Dbt5O/y0Q5DGe3tUyk0FbzA7cKgBCA7qysGjaKz6n62IfKLDN7rWoLFKDbULFo/wKkHIr5CsfMjOmEInHNVYU1huH3y1IAVg0ARj+pybeW7RbTMAgV8GG00R3EN1BIIWgQMgB3HGynlLI9qsWjwmmRex+95J7tqrhKTryajAtMTuqHAkvIRNLrFYQvpdN0+iibWgw==;5:tDzEpd94cgAR2nqXwlBOK8ksNTrhFRHKA2zPzpked/8E4AYVQy9qRbpk9ddWrINCSchWcK0XSBnxDrLj04FEdISMamYETm2qu6JED5yInc9CWvXAFxOhlpGH0G8uuOnTwbhrmFsJQCghaJjpfWlq4hnbHoeI+T0L7Q9gsxg8jWo=;7:qfJTmd0s/KcrE2sQueMIIUtU3wSXrM4nGbdHCsmNZRAEPdMzFPxgY4RXe7LcboXMiM7Q7xlAwSSkpYfBrgh5JYzGTAwz4dNDoOhxUcBklhEPqIhKlGR/Mvxke4kvYMk/8SlLa+fE+sswKuD2uh5v7BYsemc7Uyw36Mz8PUfJZboCZbjYGhCu5X1L6CMQGsWc8wglnM+vthMtt/eeqEWfC5HFxheBypmzpisQivRXlhKazAMxLp9bzv3Dd3Y9Ok/v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 22:54:58.5833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d6b94a-2d62-4d56-66eb-08d613829b0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65995
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

On Wed, Sep 05, 2018 at 08:59:03AM -0700, Dengcheng Zhu wrote:
> The issues are mentioned in patches 1/4/5/6. I will update kdump
> documentation for MIPS if the series gets accepted. Testing has been done
> on single core i6500/Boston with IOCU, dual core i6500 without IOCU, and
> dual core interAptiv without IOCU.
> 
> Changes:
> 
> v4 - v3:
> * In patch #1, idle_task_exit() is moved out from play_dead() to its sole
>   caller arch_cpu_idle_dead(). So no interface change of play_dead().
> * In patch #6, the kexec_prepare method for the Generic platform is defined
>   as uhi_machine_kexec_prepare() for all platforms using UHI boot protocol.

Thanks! I've applied patches 1,2,3,5 to a test branch with a few
changes:

    git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-kexec

    https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=test-kexec

I didn't apply patch 4 because I'm not sure it's correct & I believe the
changes in the branch above should take care of it - CPUs that reach
kexec_this_cpu() are maked offline, so they shouldn't be IPI'd by
__flush_cache_all(). The CPU that runs machine_kexec() should still
flush its dcache (& the L2), and then CPU 0 invalidates its icache in
kexec_this_cpu() prior to jumping into reboot_code_buffer.

I'm also still not sure about patch 6 - since no platforms besides the
arch/mips/generic/ make use of the UHI boot code yet I think it'd be
best to leave as-is. If we do ever need to use it from another platform
then we can deal with the problem then. If an out of tree platform needs
to use it then for now it could copy generic_kexec_prepare() and deal
with removing the duplication when it heads upstream.

Could you take a look & let me know if you see any problems?

Thanks,
    Paul
