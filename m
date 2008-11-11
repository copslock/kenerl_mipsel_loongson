Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2008 23:28:54 +0000 (GMT)
Received: from ik-out-1112.google.com ([66.249.90.178]:64803 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S23620896AbYKKX2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Nov 2008 23:28:51 +0000
Received: by ik-out-1112.google.com with SMTP id c28so138343ika.0
        for <linux-mips@linux-mips.org>; Tue, 11 Nov 2008 15:28:51 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=7RzWmHt4t1T/7c+OCBTtW7T4uzHKnmxiS0OqTCBwp1A=;
        b=g735Xl+zhtRf331eoISES3KT5IfStaDGKLA8coiNmXs7TIa4xM+wiaZQ1YcLm8s4Qy
         epk48jX0RsxS3Goy3RQOfyEOzQwXs5QlngHZntuWEnf7B5nGiZ9v55nUg/aJwBRVJAf0
         uXwSDmqLqWmkM7L1wuAs8yLnj1UGFNZ7Xot9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=j6kLUsv6h028Mt6fwkVNvGkUEs3IltyHKvgHiAHy+g/Xonq2kpAK7lfUNQ0q006eMb
         wKUiAIKJ4bG3ClEWTlwH0M9pgghvd9BWm1YLMsR9Zv6nGYGlnFbpDCNI889vcpbFbH+u
         CAuufcECGtM2kpU8K77xEFviIBbVnRsSuOfA4=
Received: by 10.210.42.20 with SMTP id p20mr9794385ebp.4.1226446131180;
        Tue, 11 Nov 2008 15:28:51 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id 7sm2315888eyg.9.2008.11.11.15.28.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Nov 2008 15:28:50 -0800 (PST)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Kumba <kumba@gentoo.org>
Mail-Followup-To: Kumba <kumba@gentoo.org>,gcc-patches@gcc.gnu.org,  Linux MIPS List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>
	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>
	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>
	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>
	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>
	<8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org>
	<87y6zphn5b.fsf@firetop.home>
Date:	Tue, 11 Nov 2008 23:28:47 +0000
In-Reply-To: <87y6zphn5b.fsf@firetop.home> (Richard Sandiford's message of
	"Tue\, 11 Nov 2008 23\:13\:20 +0000")
Message-ID: <87tzadhmfk.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rdsandiford@googlemail.com> writes:
> For avoidance of doubt, I suppose the first thing to ask is: do you get
> the segfault with the same checkout after you revert your patch?
> It could certainly be transient breakage on trunk, like you say.

Looks like it is: PR38052.

Richard
