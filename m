Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4B9Qwx32264
	for linux-mips-outgoing; Fri, 11 May 2001 02:26:58 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4B9QwF32261
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 02:26:58 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id C94A0F1A9; Fri, 11 May 2001 02:25:52 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 6A28D1F42B; Fri, 11 May 2001 02:26:27 -0700 (PDT)
Date: Fri, 11 May 2001 02:26:27 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Tom Appermont <tea@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010511022627.A17202@foobazco.org>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com> <20010509104635.D12267@paradigm.rfc822.org> <3AF934AE.38AB0089@cotw.com> <20010510110847.A2799@cyberhqz.com> <20010510162221.A1736@bacchus.dhis.org> <20010511095628.D8495@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010511095628.D8495@sonycom.com>; from tea@sonycom.com on Fri, May 11, 2001 at 09:56:28AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 11, 2001 at 09:56:28AM +0200, Tom Appermont wrote:

> To avoid any further confusion, which then are the versions 
> ( & patches ) of binutils / gcc / libc needed to get a
> linux mips toolchain we can use until the end of time? 

I routinely publish just such a thing at
oss.sgi.com:/pub/linux/mips/mips-linux/simple/crossdev.  Many others
publish similar toolchains regularly - see the list archives for
pointers.  None of them have expiration dates; you are free to use
them forever.  If you never change software you'll never lose binary
compatibility.  Likewise, you'll never get any bug fixes or new
features either.

If you mean a set of tools and libraries with which everything in the
future will always be binary compatible, we should talk - I have a
very attractive bridge I'm looking to get rid of.

Binary compatibility is irrelevant in a source-enabled world and
exists only long enough to make sure the previous release that broke
compatibility finishes compiling before the next such release comes
out.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
