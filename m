Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 21:30:30 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:37052 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035488AbXJNUaW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 21:30:22 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1101507nfd
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 13:30:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=2ewCSbV4BghJngfi9U7WPUQwDHavDD+gc9v5jKA0OgM=;
        b=bL4IxN4EPsCD4sYcYbAwFlTk+Q+p27SbXbviDtqUJewaSnOftx224UnujP9AWeL8SeQ4AB+Y5WFqWWkjJIE6GKD13zDx2XLmQFu0JIAjwouQOsi6r0HAP0jOnRa+Cpkfr33MFWZfBrjcl2zZcUuQE+AtJsEti5diQJ1evbrE25U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GVCL2osc0vSUNdE2jNzZdrLOcMi6OOfL0ezQTRiBi7rCXBucneUUyfPDslB2vFGzQZxQETlDat8klo5laTQ5u+I0mAS+ghxkcYrvr/KnH5S03OGrfnc8l44MahVT27fWOEfx5NwBB9laZ37gYCAyjSTC8b+MbuY4MpEpWHvF7r4=
Received: by 10.86.100.7 with SMTP id x7mr4374573fgb.1192393821991;
        Sun, 14 Oct 2007 13:30:21 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id i5sm5826051mue.2007.10.14.13.30.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 13:30:20 -0700 (PDT)
Message-ID: <47127C28.1000608@gmail.com>
Date:	Sun, 14 Oct 2007 22:29:28 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de>
In-Reply-To: <20071014195324.GT3379@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Could you check what "-march=mips32r2 -smartmips -mtune=4ksd" does?
> I expect it to have the same result than "-march=4ksd".
> 

I'll give it a try tomorrow.

		Franck
