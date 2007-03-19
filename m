Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:20:36 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.237]:34035 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021878AbXCSOUb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 14:20:31 +0000
Received: by qb-out-0506.google.com with SMTP id e12so4745935qba
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 07:19:30 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mPxrJRNi1EzIGH0GN1Z054vdMbw29TCZFli2GzO5GUZYh8dL0YLP3s2mv+vPusGOSRS5gFhBtsJxJS3adjLgqv4rdIULffz4uD1cSENdcpEZfDuzKYIxpXpWqweMgqW8W7WFSRS93wi8ThHSiGYKmTuv26QP8yMOkJMMY/s77Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FQ+h43kzybyAX2ILrNeVwr5kgLBf8aBjgAFoNtxdO+5OLAvfUnGghH6uh1+EWx1TEsPJkQ/KXfxsGtARqDCzs4a+1BmO03fYw/m9piKoeJ+UPwYRqz4KqfKUifl9sl/7G4UHo9roCLHmPDD3QMAYdDTtq+qOQFTvlPBPPZMdvwA=
Received: by 10.100.131.6 with SMTP id e6mr3731934and.1174313970213;
        Mon, 19 Mar 2007 07:19:30 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 07:19:30 -0700 (PDT)
Message-ID: <cda58cb80703190719v60077401x178bb6529d831aca@mail.gmail.com>
Date:	Mon, 19 Mar 2007 15:19:30 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Cc:	Kumba <kumba@gentoo.org>,
	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"Arnaud Giersch" <arnaud.giersch@free.fr>
In-Reply-To: <20070319140738.GA28895@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D8B070.7070405@gentoo.org>
	 <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
	 <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net>
	 <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>
	 <20070319140738.GA28895@networkno.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/19/07, Thiemo Seufer <ths@networkno.de> wrote:
>
> Why? A ELF64 kernel for CKSEG0 should be fine, at least in principle,
> even if it doesn't work wih the current codebase.
>

Yes you're right. I just replied to my self to say that.

Thanks
-- 
               Franck
