Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 08:23:00 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.189]:41659 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026948AbXKDIWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 08:22:52 +0000
Received: by mu-out-0910.google.com with SMTP id g7so1252829muf
        for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 01:22:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=yKTBsZVYd4dH/Hiau3Txgbhj5UDnVCObjK3658xe6dY=;
        b=t+/wsedAgmvLrE5E/jO6tuFt6tPvWggVOAYKUh32zFkxaz1AFTasCTjJTHBVJSuswBJlBGmVehItiYuc638qN6Gj+3Qp6LYbNy4oRJlmIMnjp8eDrXPI+DJOZ+b+lyzwhMxjIHZzqQSgmEmw9qYcpX2wUjpuiRVwYbmY+GN+IJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qm3FoHNuJ9WgAYOlfPBRBBou0uyQUy9bMPdvIj3MijLssqNQuEn94LyPdkSzTGgvKO8g+bfNlYVc0++Ubg8LlLOxxQuIBwo0Mc5hHmzI1oOZeK2DlgVuNz+SFvbUinpfUz+Cm/CWcFG74u9w/e2JucWV2SroX3BzbJcIEP1MrJQ=
Received: by 10.86.66.1 with SMTP id o1mr2374580fga.1194164561865;
        Sun, 04 Nov 2007 01:22:41 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm11405495mue.2007.11.04.01.22.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Nov 2007 01:22:40 -0700 (PDT)
Message-ID: <472D8110.2080506@gmail.com>
Date:	Sun, 04 Nov 2007 09:21:36 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Nigel Stephens <nigel@mips.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com>
In-Reply-To: <47160D31.5080201@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Nigel Stephens wrote:
> Aha, that probably explains it. Franck is using the "SDE for Linux
> v6.05" toolchain, and in that version of GCC -march=mips32r2 implies a

[snip]

BTW, are there any other toolchains out there that support smartmips ASE ?

thanks,
		Franck
