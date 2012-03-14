Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 19:33:26 +0100 (CET)
Received: from wolverine01.qualcomm.com ([199.106.114.254]:14345 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903740Ab2CNSdS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2012 19:33:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=rodrigue@qca.qualcomm.com;
  q=dns/txt; s=qcdkim; t=1331749998; x=1363285998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  z=Date:=20Wed,=2014=20Mar=202012=2011:33:11=20-0700|From:
   =20"Luis=20R.=20Rodriguez"=20<rodrigue@qca.qualcomm.com>
   |To:=20Gabor=20Juhos=20<juhosg@openwrt.org>|CC:=20Ralf=20
   Baechle=20<ralf@linux-mips.org>,=20<linux-mips@linux-mips
   .org>,=0D=0A=09<mcgrof@infradead.org>|Subject:=20Re:=20[P
   ATCH=20v2=2013/13]=20MIPS:=20ath79:=20add=20initial=20sup
   port=20for=20the=0D=0A=20Atheros=20DB120=20board
   |Message-ID:=20<20120314183311.GA8265@tux>|References:=20
   <1331721931-4334-1-git-send-email-juhosg@openwrt.org>=0D
   =0A=20<1331721931-4334-14-git-send-email-juhosg@openwrt.o
   rg>|MIME-Version:=201.0|In-Reply-To:=20<1331721931-4334-1
   4-git-send-email-juhosg@openwrt.org>;
  bh=W4OyubaSdzc9bicabu63KleprHXSLgu5gGS8/v7ioJA=;
  b=t++TmE/G3QGCvYUui5udegwqWjZT2CTHWAMGoZfrPNEnmAwbNcQu0cTp
   PeiHaumeDD9iIYMvwOC+ZH5JmkE3/BBLSZKqFu0xrFZzxegnrmr9sVxqb
   RRIeNx3MLBVvfGtjSR1Dg+IUhD6+NiEsx60sIAkkF1oHMmEnuONsuM1IS
   s=;
X-IronPort-AV: E=McAfee;i="5400,1158,6648"; a="172463732"
Received: from ironmsg02-l.qualcomm.com ([172.30.48.16])
  by wolverine01.qualcomm.com with ESMTP; 14 Mar 2012 11:33:14 -0700
X-IronPort-AV: E=Sophos;i="4.73,584,1325491200"; 
   d="scan'208";a="119711349"
Received: from nasanexhc07.na.qualcomm.com ([172.30.39.190])
  by ironmsg02-L.qualcomm.com with ESMTP/TLS/AES128-SHA; 14 Mar 2012 11:33:14 -0700
Received: from tux (172.30.39.5) by qcmail1.qualcomm.com (172.30.39.190) with
 Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 14 Mar 2012 11:33:12 -0700
Received: by tux (sSMTP sendmail emulation); Wed, 14 Mar 2012 11:33:11 -0700
Date:   Wed, 14 Mar 2012 11:33:11 -0700
From:   "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <mcgrof@infradead.org>
Subject: Re: [PATCH v2 13/13] MIPS: ath79: add initial support for the
 Atheros DB120 board
Message-ID: <20120314183311.GA8265@tux>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
 <1331721931-4334-14-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1331721931-4334-14-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.30.39.5]
X-archive-position: 32707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rodrigue@qca.qualcomm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Mar 14, 2012 at 11:45:31AM +0100, Gabor Juhos wrote:
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
> ---
> v2: - remove USB controller registration, it will be added
>       by a separate patch-set
> 
> Ralf,
> 
> The mach-db120.c file is licensed under the Clear BSD license. That
> is based on the modified BSD license and the FSF's [1] site states
> that it is compatible with both the GPLv2 and GPLv3.
> 
> However if you have concerns about the copyright we can resubmit
> this file under the ISC license [2]. The ISC license is already
> used upstream by the ath6kl and ath9k drivers.
> 
> Thanks,
> Gabor
> 
> 1. http://www.gnu.org/licenses/license-list.html#clearbsd
> 2. http://www.gnu.org/licenses/license-list.html#ISC

Gabor, please resubmit under the ISC license. The patch
has been pending since December and I really do not
want to wait any longer. You can just resubmit this
one single patch.

  Luis
