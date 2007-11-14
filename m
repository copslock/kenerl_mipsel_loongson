Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 15:14:12 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:10706 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029183AbXKNPOD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 15:14:03 +0000
Received: by nf-out-0910.google.com with SMTP id c10so175712nfd
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2007 07:13:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nu8LxLXgH/BlThpSYnwMCbWIuDgR54wTRkgcoZ4bJ3E=;
        b=YldHWVxNyxZwxoYE/gURzOUAu06Za/YPsdBU7umpFkLA5K5W7QHPMla7piWAJzRDBUBPKzBPUhLnDSjT9Wa1YSI/nhR0iwZoaiT+OQTwA2V2eujRTF9fJzB4sfbG4iDA/mens42vIBQa61rczLgoYF/TcebXc6qI9hZZIM9eEiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nEOcRsoHCt7PjwsvtLkxw23iuVoMPMPVF8bXBkCuFb8GsK/1+3owtSpU7Lwz2yeRdQwCq1n6fMJwW+IBHjYZ3fS4wUC9FvSjeMEjYiD9wq2kY1K4GjBxHTT08fuiTATSltWzrVnClOmzwM1ZlJeaYIvF3oCIJjSNcnM6jlfKRrc=
Received: by 10.78.167.12 with SMTP id p12mr8166935hue.1195053230606;
        Wed, 14 Nov 2007 07:13:50 -0800 (PST)
Received: by 10.78.179.18 with HTTP; Wed, 14 Nov 2007 07:13:50 -0800 (PST)
Message-ID: <cda58cb80711140713r701c5e56hf80741cd70122714@mail.gmail.com>
Date:	Wed, 14 Nov 2007 16:13:50 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero()
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20071114134840.GN8363@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4736C1EA.2050009@gmail.com> <20071111130130.GB8363@networkno.de>
	 <473AB0B6.2070208@gmail.com> <20071114115807.GL8363@networkno.de>
	 <473AEB52.40501@gmail.com> <20071114134840.GN8363@networkno.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On Nov 14, 2007 2:48 PM, Thiemo Seufer <ths@networkno.de> wrote:
> What about using memset.c and fill_user.S ?
>

Quite frankly, I don't know if we could create memset.c and put inside
a function of 2 lines. And I don't think we're going to add some stuff in
it later.

What about implementing fill_user() in C ?

-- 
               Franck
