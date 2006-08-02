Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 17:57:37 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:60023 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133453AbWHBQ51 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 17:57:27 +0100
Received: by nf-out-0910.google.com with SMTP id q29so713901nfc
        for <linux-mips@linux-mips.org>; Wed, 02 Aug 2006 09:57:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=q8TrG9gFL+2C8ecMCVkwi4AUuA3yC6IoHL2PzVM8SAemhLvpeJSsPZgHvW6IZQ0s/OKdPoUz6+so/yHSwaZMIhJvEnxd2h/d+542JJWdWwOQqAD+RFGA07++6LvFt239BNZy/bquIypUwlndD0wFGSdouSFnfYQ/X71wH8wv5Cs=
Received: by 10.49.43.11 with SMTP id v11mr2527341nfj;
        Wed, 02 Aug 2006 09:57:26 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l27sm149030nfa.2006.08.02.09.57.25;
        Wed, 02 Aug 2006 09:57:26 -0700 (PDT)
Message-ID: <44D0D942.5050809@innova-card.com>
Date:	Wed, 02 Aug 2006 18:56:34 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
References: <44D07C97.2040008@innova-card.com>	<20060802.202540.10544424.nemoto@toshiba-tops.co.jp>	<44D0A3B0.40601@innova-card.com> <20060803.010000.25909906.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060803.010000.25909906.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 02 Aug 2006 15:08:00 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> does this updated patch make you really happy ? If so I'll resend the whole
>> updated patchset.
> 
> Yes, looks good for me.
> 
> Just one comment: no need to do "pc = pc != ra ? ra : 0" anymore.
> Just "pc = ra" is enough, isn't it?
> 

Well I let it just for cases where the caller does not reset ra after the first
call. It should be safter. But I can remove it if you want.

		Franck
