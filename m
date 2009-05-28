Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 17:00:22 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60116 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023251AbZE1QAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 17:00:16 +0100
Received: by ewy19 with SMTP id 19so5738651ewy.0
        for <multiple recipients>; Thu, 28 May 2009 09:00:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Wf/ZkFIQt1uoPR0vbBp5HE0LfTF3KJM5v0aD2vY8zl0=;
        b=emkeSKbwW7uTk6ituWTBNKhMQWgfGEAxYhhKMHd5SPNdQFdJ6dyyzNLIz+NCeqZfHs
         pLHZL1DKzfEpBqQHcpbszk5GXAIJaLKwOh29nKkt4+zHPvMq8dJN+UUA2sfJcO1yLg71
         RP0oIfuXyn6NzZG43krYjnHD6wR401WQgcDY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QjiCoLMgj08BwbUTEZlCQdvLHmWU1oa47Copf/2MENL9u1m3Nyxp6owi56LVIgmbCY
         67xxrvDzuaC8VCUSrfQVwQScfRFnTLzFZLxaPbnNQ9SXyE0xCAtGQJfYM9szcfcU2FAV
         Jvb0j4+Kh8dJzwHgIzxXL6dka5Z4eYt0/z1S0=
Received: by 10.210.10.11 with SMTP id 11mr2971637ebj.72.1243526410794;
        Thu, 28 May 2009 09:00:10 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm283217eye.26.2009.05.28.09.00.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 09:00:10 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
Date:	Thu, 28 May 2009 18:00:03 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, wuzhangjin@gmail.com,
	Richard Sandiford <rdsandiford@googlemail.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com> <1243521105.5183.5.camel@falcon> <4A1EB116.6080404@caviumnetworks.com>
In-Reply-To: <4A1EB116.6080404@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905281800.05772.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 28 May 2009 17:43:18 David Daney, vous avez écrit :
> Wu Zhangjin wrote:
> > Hi,
> >
> > On Thu, 2009-05-28 at 13:31 +0200, Florian Fainelli wrote:
> >> Le Saturday 27 December 2008 16:19:40 Richard Sandiford, vous avez 
écrit :
> >>> "Maciej W. Rozycki" <macro@linux-mips.org> writes:
> >>>> On Wed, 17 Dec 2008, David Daney wrote:
> >>>>> This is an incomplete proof of concept that I applied to be able to
> >>>>> build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit
> >>>>> case or the R4000_WAR case.
> >>>>
> >>>>  The R4000_WAR case can use the same C code -- GCC will adjust code
> >>>> generated as necessary according to the -mfix-r4000 flag.  For the
> >>>> 32-bit case I think the conclusion was the only way to get it working
> >>>> is to use MFHI explicitly in the asm.
> >>>
> >>> No, the same sort of cast, multiply and shift should work for 32-bit
> >>> code too.  I.e.:
> >>>
> >>> 		usecs = ((uint64_t)usecs * lpj) >> 32;
> >>>
> >>> It should work for both -mfix-r4000 and -mno-fix-r4000.
> >>
> >> Any updates on this ?
> >
> > I have updated it to this PATCH, could you help to review it?
>
> FWIW, Ralf also has a patch, that I have tested, that takes a slightly
> different approach.

Are you refering to this one: "MIPS: Rewrite <asm/div64.h> to work with gcc 
4.4.0." ? If so, it does not solve the problem for 32-bits kernels.

>
> In any event, it would be nice if one of the patches were merged to
> 2.6.30 before it is released.  GCC-4.4 has been available for quite a
> while now.  Not being able to build the kernel with it will become a
> larger issue as time goes by.

Definitively.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
