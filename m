Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 01:21:09 +0200 (CEST)
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:13968
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994572AbeH3XVGH70tY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 01:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhsNi9ZvOgHx/RFMp22jUMd5DX+m24oi27+fmqOvjzc=;
 b=B9quTJYN7QUjtegUtyjAwoUKc82d0eC7cGvkzwV2BsKQ50FrDudG4hZa39cHcbXNNA0s91R3nhkKPxgMdWMANklHdNAzcd2UBZNTXtgQlF4uoXMO+IL0gIBBuLyBqA1hCJFZHFQyzmVdIXI2vtk6LvKbz5aJlkrGOoiok7PqPcA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 23:20:55 +0000
Date:   Thu, 30 Aug 2018 16:20:53 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/6] MIPS: Make play_dead() work for kexec
Message-ID: <20180830232053.3vptoq5koytuwxnn@pburton-laptop>
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
 <1531358868-10101-2-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531358868-10101-2-git-send-email-dzhu@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0018.prod.exchangelabs.com (2603:10b6:805:1::31)
 To BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06bb9138-79da-48f0-b7e4-08d60ecf3ccc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:U38zo49sSxgQqr3O4yN+EqzvZCwstwgcpxfayZmjp5UcLVfM8kkoAqzRWJXO8trQnm2JfL6VOo0G8ABpwMDG5v61gILw/IHfA/4i50aRa2X78jfYdCtcyk7HKYQSOfNqr1Gk4AM8PP11qU1V/DbbgwYZkZzxLlQZQW9VLhWcOQSxwhSHOzkh29XdeEX55+z7CWkOrVCepA8AWwyDu3A9uFoTC/7ucqFTu1WLePfD4b5Vy4KNaPfcI65zld0GsFQe;25:joJzou6LDSZlBTIVOrmucRB3UO7rAlOtLxqfKJyh2GujxiZYe1qG7/3+qp2q2Lj0gtj8KNJ3HYEXdW7JXVWDbKdttOK6753gn+NyVZP94xfDgTtfg0SFAGSneG5GEQhXHqQnU8xwIBSFTmXg+d1OySjP6EMhvCifuPgBcqd84JrD1unNAYmP5ltMbYnKui8VoJvgECoLT5Yv1vwfX2IY+jelgOmOCWvnIhsAKxQPLCJCAg4mA0Q3s5+NPN7ilhfaFrPuvS1i3A2ZFxFjV3f+sAaTyjGH6B6qJb621cSSOKKF4lR9mJQPDwAZ+OCLxQhnSWGR5gpyqnp2fS91BSnU8g==;31:1Bzsth/vHrlYsBsQJWS9vXik3s9s7O5nLI4PY/I4HcSBaVQUMrXJGX66v+ZXUSD25W6L7qLdAbuUB7xCwBlN2wnWQrqPplQPM7WQKCTgM5C2BetAjXvc2hI4eA11rWgYqyc4Tpol0vD3Atx0MUdkabRwhY+i8BbrcrZSkz6F7Kv2BULFZODlcSvEdMQGbUCCB3S1nrR3W4wlsl9QIWlYLCU2/SSCFcoYxDvjJ39bKis=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:zN81pESTVw547p22qNLtYDuEQIp3BcoCFvYff+syx72r4E4gyocYqHNDUbwXW0UY95lUWeadCLHzwtOT/AEznpEhm6MnZ1uTa/3Htyvs3vBxmXANS4uiH/hrG1H9cVpCAC1DILPXIkObLlkB8YkScC34wgoz+RV9qhGPTyUIy6OzpPVm1ap0J0E02Q+/UIJefeZ/oLIiNdmKEu6hwf2vlN9XdLPhrG6gt95KE4gvCNCuibJvz8xk7sNXvYDPUC5s;4:qC+XBQuLyZvYd3zyoWFLCYW7dOHbqbkucRREzd2DKYMIsrII4m/wQiOifevRUWKIFssWI/gCNl0axzVupatvGojcaopDz3HgaR115H5DCehwiWc3Ayrmc9v3fowtSIEy1Cl21Eu+vCKM0DrBakRkY0wdHBgpOySN2OtJhOCJCjHMQ9vCS99ZSldgcqh55hF/FybfKJduuQ2V/DOEKVLRfp9/q1n0nXQ3+13pTpYRi+fLOq2komUmQhiWXtEadEJgW8c5afS5BP4A0CbQXB/5zg==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4935766C866DD928B6E94474C1080@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39850400004)(366004)(376002)(136003)(346002)(189003)(199004)(97736004)(68736007)(26005)(5660300001)(3846002)(47776003)(6116002)(1076002)(33896004)(76176011)(52116002)(44832011)(6496006)(9686003)(66066001)(23726003)(53936002)(476003)(956004)(16526019)(16586007)(11346002)(486006)(76506005)(2906002)(105586002)(42882007)(81156014)(106356001)(6486002)(25786009)(8676002)(8936002)(4326008)(450100002)(446003)(33716001)(50466002)(386003)(81166006)(58126008)(316002)(6862004)(478600001)(6246003)(305945005)(7736002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:GH+OQaLzsIrB0zrdPdie0MhXi+SkOi206I+riJf0i?=
 =?us-ascii?Q?bRQUxB8435Xr1eoboTtNj8PAPecOE9joRM0ZiJjRnqCMi2oPoP9LV4cjGIlf?=
 =?us-ascii?Q?G3k/uCrGSP4aEeXQ79T1SMxN371CJAMa7cxnUZLgGjGyKc3k9pGmom7zvKmA?=
 =?us-ascii?Q?JgUHfEYfNaP6xFU0ut0Zduwy+9fMXWylIm7OSCyOJe++yjNYJ9vkRyNY0Hqx?=
 =?us-ascii?Q?pSZjx9LxIMkrmaki1w27PmwUa/MmbLXzS/YbVcOGLFzLJ20Xro8+7y+c/LUC?=
 =?us-ascii?Q?CdtVH+LEYDV51u85TyRX+0LJz17F3dyu0z1uue8uPmEfcckrajeHDym2jvZq?=
 =?us-ascii?Q?EIFBE1RFJlY7OGiCynyg+zS4IbiOXs1qDjP8+/9dndlwa+adDH5zrujaID0c?=
 =?us-ascii?Q?579NUTF5rJIBftPDXeODu6MpbjHhKPjhvGR0T8PJ6QmQPzWvxmkOpClBtl7+?=
 =?us-ascii?Q?tMMcwgmk+NBqawxGDlW0eYL7txHf0dj3E3reLRhFj3O2kgFtMviPXvFQWaWc?=
 =?us-ascii?Q?etjwDOjTtGIWM/lzTzhWHEG1XODSlBGTWsOPVPIggtx8eMJEI8sZcR/XbIO6?=
 =?us-ascii?Q?od4iLzX78q7h8GdOmKWWHgOfG7b+MyoUewEWgI7hjgT7BCTPINwAqlsqGjjz?=
 =?us-ascii?Q?9Y+wFgK5YWGa+Guu1024JAK4JVL91Gv3OOhoxAtGEWiks31HueaCuGXBDkrU?=
 =?us-ascii?Q?yUmQrsFdl9zZgNCJF/n0O6/lX9wNzwUBlAa3Yia8CshAh4619vXSPjKK3nh2?=
 =?us-ascii?Q?ngpAfVKVUpHYtBzX3EOfglq/oimd3PBFKKxg2CgjPrsz5l6oGZ6TY3s+7kpK?=
 =?us-ascii?Q?ESzlMDEyL3Ny9u8ow/nAVYNDB3NlMqffUNc5P5dkzc7FNdfRk6TwxVoaDvku?=
 =?us-ascii?Q?m5VpAefNChmJs4CLEDo6ca+NdEi+xHcicovVx/NGfRseaaaOdYj4xrkGk6eI?=
 =?us-ascii?Q?XgHD0Fpmu64oopLhc8eVP4JZvOnWhQi+eckyVFo0cWE6jAxTCQ9xD2q7LXVP?=
 =?us-ascii?Q?IeuCTh+JtRMV3mGpBeu3vkoYsVt6QReGfBltjtUbwnoSr1Nx8xFyDw1BIRfg?=
 =?us-ascii?Q?eZII8Cdz50gViK4QSUM6F1Js+AlQ7ixUwP4SCoTVYVGelW8zbEeAx37rUgyS?=
 =?us-ascii?Q?Dl14asSJXLtY1KMLLjjHP2J+645Iv068Yp9XrGq0cz4Tx6KfHj05jrlx8ktu?=
 =?us-ascii?Q?iJmvOjihzPGiEbm1t/feTo2ArU2jZt+eys61WFtkmEfozYJKKl/Sv0InIrZB?=
 =?us-ascii?Q?Gj2aD0dSREFUze/sTtsGrRlKEeKtgK9D8Y8/o7P?=
X-Microsoft-Antispam-Message-Info: Nbo0Qqj4dOzu3kJH7B5+mDcVNCZuye1LGedjQAShA5UUWI3FbnBF1djkNqCo5/GeQPSC3uNp75U6ltTb5k1ebFuIwBn5tMsNjvlWS2TGukkxg6uWvt7CczCehkaTgIPEZHaO1R+KiY1DQ36qwMQqgYYwTqghxExSLXcZx/TRfYZ8n9GarT1Ldgu3xJ9Th4B3HCfJCBr4HSPnLxZi37ANmAwvn/N8nILTbjWbyfUvX7TVc3Vx8CsMNpYmDqaWlt87e9+QAWZ4SBCrH1fk+SMeOBvvDU6meY+dRHrfzc8x0zCQPmfFt3ptocOBpZ6zM+7aXzAj46oZCSoDVGVDunv3+37hw97UOBGtacyjwlMAY6U=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:4iJ7IGB2r2m9QVDMs53OI/AGccQXopYFrImFtt/l3DVX4TxVRW9aWZZTB7hGcTJSSad5GfCc3Wp8EahZWMnY+nTMNH+YvL5ETjJtwkdjbIkbpXHPwUiOZK38G2r5YLD6e0c91y+Y4fFk7C/Nd3iFcLdxZI+T3ao5T4l+Bd0CNuEuK9iu55XBqEbW8RjXJfX6Q7ZsRYCkjjoFVzzLrR26FtvoVvVQe3/kEdoAi+18ORPkxXDPLCuXWYM8KLmpMR4KF6V+eBCusspy1kz71EOhotx0RhUD0MC8sYIgjGolm3nZEQVIZnQDVUXsx+ml0rpS0G4rHMtdERTeHIq9ZY2JJZLtCu7RY35EAflt5vjYq1M4+XYLsukXgY45SWdnii0nHKITGRaHbdBPkr7CgjmYsRmxKtRb7uKxPL9ZHv/jbsfRo1IYQb/RLPjjOfmGjtQZskjRUgnSBIjZxXsp5W2ReQ==;5:5N079ePCbbvxaeqVvAubfXEh502RwIHJydImB++TCXy0NcWYSxn6GRH5AEVAi4rvv5/tmFiDIgxFjQTT1ds0cz0lEWip909AWlgMcNaTYJ8CrWKXN82r3sQI0uTNdiEk4Jf6WaXKDZg0B0bhSUToZea2x1YhCIdo+YT4+RtfnzM=;7:0krDFiPOXI3ZKYjrHwsL9U5YY30j2gdYfQQZQDhwX7vDUdHZvxRIonaHO810cfmvvzVOHuU8zQJz33ZUyu6eLDqm8XGXzjys5bGcVJkafKOV9V283rVB+tX4iKWwTZlAFqip8+/G1BdgOv2snlUNr72uf2AGy3KGQWpnHwe8FgeqGgjVHb3IfrhiYpFsBbnD0FwIosomCjKQys9pMoepl5052rHFp6oBL/q5UqMX1nRGThxraTbGm6xH74+CWVok
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 23:20:55.8490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bb9138-79da-48f0-b7e4-08d60ecf3ccc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65809
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

On Wed, Jul 11, 2018 at 06:27:43PM -0700, Dengcheng Zhu wrote:
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 03f1026..4615702 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -426,12 +406,18 @@ static enum {
>  	CPU_DEATH_POWER,
>  } cpu_death;
>  
> -void play_dead(void)
> +void play_dead(bool kexec)
>  {
>  	unsigned int cpu, core, vpe_id;
>  
>  	local_irq_disable();
> -	idle_task_exit();
> +	/*
> +	 * Don't bother dealing with idle task's mm as we are executing the
> +	 * new kernel.
> +	 */
> +	if (!kexec)
> +		idle_task_exit();
> +
>  	cpu = smp_processor_id();
>  	core = cpu_core(&cpu_data[cpu]);
>  	cpu_death = CPU_DEATH_POWER;
> @@ -454,7 +440,8 @@ void play_dead(void)
>  	}
>  
>  	/* This CPU has chosen its way out */
> -	(void)cpu_report_death();
> +	if (!kexec)
> +		(void)cpu_report_death();

Is it a problem if we just call cpu_report_death() unconditionally? At a
glance it looks like we'd just change cpu_hotplug_state for the CPU, but
since it's going to either power down or hang anyway that seems fine.

If we could do that, then the only other thing the added kexec argument
is used for is preventing us from calling idle_task_exit(). We could
instead move that to arch_cpu_idle_dead() and not need to add the extra
argument to each implementation of play_dead(), which should make this
patch a little cleaner.

Thanks,
    Paul
