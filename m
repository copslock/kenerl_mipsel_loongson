Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 20:34:26 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:56538 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20031328AbXKEUeS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 20:34:18 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1245627nfd
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2007 12:34:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=n+dXS9t+JH/C7q/97YHe72YFCvMfojFJol6dfXQgII8=;
        b=L45Gv7dGPf3QahE5Adk529hVlvRAOLsRD4CcCyuhxlotU5w5OEJ5rrWoDbC26Fh25huRTWrNy9Szl+FXJb30huGwXZOuQ9quyeV1zh72OwxM5KGPEkXlfPADAg+1f7EqStl7l9KvJ3L9kq8M0Er2qWYQTiXQ8iGGc/tJYvUADAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SAuepVkXfIqrzzo2mCge9d2Xhr+oknnQ8+C5LoUo5YCvy/CktwCd7V9fKqfIeFP0xqd1Rr3V0ZBjH6K41wx4aFSdD2guJmqBc1Eh2gFQEN8ms3F211mDTCg/nYVQOCE7TjAkG2Hsnqbnuhmr1reuY/NMCSEhOi2LRXobEQ2CPss=
Received: by 10.86.99.9 with SMTP id w9mr3699336fgb.1194294847691;
        Mon, 05 Nov 2007 12:34:07 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id d13sm13028367fka.2007.11.05.12.34.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 12:34:06 -0800 (PST)
Message-ID: <472F7DF2.10901@gmail.com>
Date:	Mon, 05 Nov 2007 21:32:50 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl> <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl> <4713C840.8080206@gmail.com> <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl> <4717C1FB.4030602@gmail.com> <Pine.LNX.4.64N.0710191239490.13279@blysk.ds.pg.gda.pl> <472D82D1.1050401@gmail.com> <Pine.LNX.4.64N.0711051234230.857@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0711051234230.857@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 4 Nov 2007, Franck Bui-Huu wrote:
> 
>>>  Hmm, isn't what `info ld' says enough?
>> Hmm, I'm must be blind but I missed that each time I read it. Could
>> you point out the section number please ?
> 
>  That's section 3.8, I would guess, but if what you are looking for is not 
> there, then perhaps the description could be improved.
> 

After reading section 3.8 "PHDRS Command", I still fail to find
something interesting.

		Franck
