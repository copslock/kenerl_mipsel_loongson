Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 20:21:02 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:45941 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20031037AbXKDUUx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 20:20:53 +0000
Received: by nf-out-0910.google.com with SMTP id c10so982898nfd
        for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 12:20:43 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=rg5FZYmd7jDiYl+851gemUjlm5PSUS71CMwOLnVNduE=;
        b=fcNKCI3AeWEYuCc/yT9UzTlPPxKjddoJm64fW6H6bSAgzY5Mu0d20dsTin8cYj0QuGyghUIqGjzODJHQ2cRAnbAjzFjkpCra+AKuJjYivh+UJ0msS44HNXj411XRcNbMrU7Nocr+ZWCv79kyjG7/xoANxVx//tp/uggqi/kciD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mqURhfT1PUYhXzi2W6uRzYGaV9yM5uLHOCf8SQa8peDOZYqSUUh8SzIxaXXzOUVYSYCJu5vtnZ7pFM0nHyzyfbgE5v17ZFRAOfHTuV8SJjMabWqwmuLZArW2RuBjvP50xjklE26qKwSZv8hkEbNrNLpJQw8SUFanLQqvJs7xRfU=
Received: by 10.86.86.12 with SMTP id j12mr2781116fgb.1194207643382;
        Sun, 04 Nov 2007 12:20:43 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j12sm3231868fkf.2007.11.04.12.20.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Nov 2007 12:20:42 -0800 (PST)
Message-ID: <472E2955.3000803@gmail.com>
Date:	Sun, 04 Nov 2007 21:19:33 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de>
In-Reply-To: <20071104174710.GA9363@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> 
> Latest GCC upstream supports it (in SVN since 2007-07-05).
> 

Good news although gcc 4.3 release is planed for end of January.

Is SDE gcc going to be obsolete after this release ?

		Franck
