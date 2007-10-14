Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 21:21:31 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:50069 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035463AbXJNUVX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 21:21:23 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1100381nfd
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 13:21:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=qd1v6BJpdbbswRGIkyV+6pE5vcbeOWrbyulH8ZtAJSE=;
        b=elN8v1cC2IviwmY+CfZMEYYOGq9qG/jRTsdV+nY7tcOtNEmRoWdz7/HFw205Oyd/rFKdQ3GfcQfq/2FJrhPfofiZhQ0EL3x4zTSf60vWFmocT9JmzlF9TKZC/LoZMqdq9EYQxZglPzzZYuBHF8FrbUFwuA3U24LvIYCkXiAZWeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JVlGYNr/BE8erAMahVuf5aOvkl5xaz/szYpNVSlNgjFWXPhBxXXTb0MwU09Si2VpUrYFZyhkyJ/gvn1uX8itCeYRC4aGCVucl/QWmDh0YjJfe+KeZZqOTD2tuDDG0BduLPkbA5DPvMsaSLKmtR7/cnqplabIDx7tEfk2gCtnYN8=
Received: by 10.86.70.8 with SMTP id s8mr4409473fga.1192393265507;
        Sun, 14 Oct 2007 13:21:05 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id w7sm5793127mue.2007.10.14.13.21.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 13:21:04 -0700 (PDT)
Message-ID: <47127A04.20008@gmail.com>
Date:	Sun, 14 Oct 2007 22:20:20 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] tlbex.c: cleanup debug code
References: <470F16B9.7030406@gmail.com> <470F1775.7090807@gmail.com> <20071012171120.GI3379@networkno.de>
In-Reply-To: <20071012171120.GI3379@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> I don't like this patch. I wrote the code to
> a) print the handler before the (potentially fatal) memcpy. Touching
>    EBASE for the first time is a place where things like to go wrong.

Sorry I don't see what you mean...

Do you mean ebase (BTW this name sounds very local...) can be set to
an incorrect value and therefore the memcpy can get mad ?

If so I would say that with this patch applied you can easily guess
that an issue happen in this place because the log would be:

	Synthesized TLB refill handler (x instructions)
	<nothing>

and there would be no dump of the handler.

Whereas currently we would have:

	Synthesized TLB refill handler (x instructions)
	<handler dump>
	<nothing>

and now you don't know if the crash happen in the memcpy or later...

And it seems better to dump the code which is going to be _executed_
instead of a temporary buffer.

> b) avoid printing leading nops which are never executed. The trailing
>    nops have less potential for confusion.

Well, I disagree for 2 reasons:

   1/ By printing the leading nops you can detect a bug which would
      wrongly write in this unused part of the handler. That's one of
      the reason I added the handler instruction addresses BTW: to
      skip easily this part when reading the dump.

   2/ This is just debug code and it should not make the real code
      harder to read. Take a look at the end of
      build_r4000_tlb_refill_handler() function. It's not really
      obvious that this part is only for debug except the memcpy.

But you're the maintainer of this file so if you still think I should
drop this patch then I will.

Thanks.
		Franck
