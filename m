Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 07:24:53 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:3690 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021820AbXKFHYp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Nov 2007 07:24:45 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1358760nfd
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2007 23:24:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=rDMlNyVBA0u3aNDtER6noLjjNPF754KVBkFI+hbBRaE=;
        b=TfxvlBngmFq+/bq9y4yetR4cFf8UcKsavKJhELHqvxN+6fPX/ZVYSunzphFhD9IeNlW6MZny+f461ACKtP1lWVeeHy8IlQ2K8iqa4jFuRaMgMWzp/21lkj11fx32Potfb2Fpw5oOhBonXbPPOzi5Fz/R0wGgVrS7xcW01JFI2N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=G9x6AY5NX7f1lHbiGB7hL93Dk0cCs6aeKGonYJnAYWTVVCpDCQaOYuwldHBcTEZVyzYrLnHGg+0CiX610tS1LSJBPWi/nq7pTyTx2laTO11HEySGvYK0Wdl7PiTjBq+Trp8R56V5hoJ9OnFVisAdAcoVPQ7pSCyx8uojaSaYEY8=
Received: by 10.86.91.12 with SMTP id o12mr4100015fgb.1194333874429;
        Mon, 05 Nov 2007 23:24:34 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 28sm13642078fkx.2007.11.05.23.24.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 23:24:33 -0800 (PST)
Message-ID: <47301663.2030202@gmail.com>
Date:	Tue, 06 Nov 2007 08:23:15 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>, Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de> <472E2955.3000803@gmail.com> <20071105113618.GD27893@linux-mips.org> <472F8C82.4080406@gmail.com> <20071105233025.GB12514@linux-mips.org>
In-Reply-To: <20071105233025.GB12514@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Nov 05, 2007 at 10:34:58PM +0100, Franck Bui-Huu wrote:
> 
>> It's actually hard to know the advantages of using SDE over a stock gcc.
>> The only difference I'm aware of is the smartmips ASE support in SDE.
>> But since this support is going to be added in stock gccs, I don't see
>> any advantages now and I'm wondering if I can give up using SDE...
> 
> In general terms the toolchain has been more reliable and had better
> support for MIPS processors before FSF gcc.
> 

Good point.

		Franck
