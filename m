Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 10:23:57 +0200 (CEST)
Received: from Smtp2.Lantiq.com ([195.219.66.201]:60121 "EHLO smtp2.lantiq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870542Ab2JJIXuHXcP9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 10:23:50 +0200
X-IronPort-AV: E=McAfee;i="5400,1158,6860"; a="780935"
Received: from unknown (HELO MUCSE047.lantiq.com) ([10.64.162.236])
  by smtp2.lantiq.com with ESMTP; 10 Oct 2012 10:23:44 +0200
Received: from MUCSE047.lantiq.com ([169.254.2.183]) by MUCSE047.lantiq.com
 ([169.254.2.210]) with mapi id 14.02.0247.003; Wed, 10 Oct 2012 10:24:36
 +0200
From:   "Hempel Ralph (LQDE RD ST PON SW)" <Ralph.Hempel@lantiq.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Chris Dearman <chris@mips.com>, John Crispin <blogic@openwrt.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] MIPS: kspd: Remove kspd support.
Thread-Topic: [PATCH] MIPS: kspd: Remove kspd support.
Thread-Index: AQHNpnWqKKT4bUFh1k+6gtPoqSJyVpeyBgUAgAAt46A=
Date:   Wed, 10 Oct 2012 08:24:35 +0000
Message-ID: <0C3C183B417EB546A5A99361496B4C3F6434EDF5@MUCSE047.lantiq.com>
References: <1349821203-23083-1-git-send-email-sjhill@mips.com>
 <20121010073826.GB6740@linux-mips.org>
In-Reply-To: <20121010073826.GB6740@linux-mips.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.174.103]
x-tm-as-product-ver: SMEX-10.0.0.1412-7.000.1014-19256.002
x-tm-as-result: No--27.568900-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ralph.Hempel@lantiq.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


> With kspd gone, the question is if there is still any point in keeping
> CONFIG_MIPS_VPE_APSP_API and MIPS_VPE_LOADER?  I've nuked those
> also but I'm holding back for others to get a fair chance to speak up against.
> But the fuse is now lit.

We're using the MIPS_VPE_LOADER to load our voice firmware into the second core.
Could you please leave this feature in ?

thanks
Ralph
