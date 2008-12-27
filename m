Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Dec 2008 15:19:59 +0000 (GMT)
Received: from mail-ew0-f21.google.com ([209.85.219.21]:43142 "EHLO
	mail-ew0-f21.google.com") by ftp.linux-mips.org with ESMTP
	id S24208140AbYL0PTz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Dec 2008 15:19:55 +0000
Received: by ewy14 with SMTP id 14so4401487ewy.0
        for <multiple recipients>; Sat, 27 Dec 2008 07:19:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=4JbDEwZIkz+nUe0lsVFY4uwQqYFeoWPTEhHYtJ4D4ws=;
        b=CZaF0HY5GUOxhsHo/ah1vDzGcnqngjNLDYlVl5YlK3qBzdL5TkZjD3f8R/mhY5p5F0
         GhYOlSl8jVGoQJ6rv2SyRVkFrElJFYTGBUjMXtoQlMi8y+JvAcI0luHRX7qoto5SKPOg
         kMvP/oiG0CYJP8jEKBAFvSAfGfOF9V097RXcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=KIGGHB9mZntTOK6Rul6jLQOUI6LM2UnrIiYQZbCn+5Ek5gcdL81yXHqnvZh3pR1S9v
         nZXgdkD8Sequ2LTIz/6C4nTKMuboq7JobWN0ZyAGWgdjB3t+up7BqpOXG0HwK0osYWG1
         0yxmTn0pPueuwv/558F29fT4sQdQqBB8W3W7o=
Received: by 10.210.120.7 with SMTP id s7mr13847933ebc.184.1230391189232;
        Sat, 27 Dec 2008 07:19:49 -0800 (PST)
Received: from localhost (79-67-73-42.dynamic.dsl.as9105.com [79.67.73.42])
        by mx.google.com with ESMTPS id 3sm7254993ewy.34.2008.12.27.07.19.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Dec 2008 07:19:48 -0800 (PST)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,David Daney <ddaney@caviumnetworks.com>,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
References: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com>
	<alpine.LFD.1.10.0812190041080.6463@ftp.linux-mips.org>
Date:	Sat, 27 Dec 2008 15:19:40 +0000
In-Reply-To: <alpine.LFD.1.10.0812190041080.6463@ftp.linux-mips.org> (Maciej
	W. Rozycki's message of "Fri\, 19 Dec 2008 00\:46\:11 +0000 \(GMT\)")
Message-ID: <87wsdl63xv.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Wed, 17 Dec 2008, David Daney wrote:
>
>> This is an incomplete proof of concept that I applied to be able to
>> build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit case
>> or the R4000_WAR case.
>
>  The R4000_WAR case can use the same C code -- GCC will adjust code 
> generated as necessary according to the -mfix-r4000 flag.  For the 32-bit 
> case I think the conclusion was the only way to get it working is to use 
> MFHI explicitly in the asm.

No, the same sort of cast, multiply and shift should work for 32-bit
code too.  I.e.:

		usecs = ((uint64_t)usecs * lpj) >> 32;

It should work for both -mfix-r4000 and -mno-fix-r4000.

Richard
