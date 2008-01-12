Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 20:40:43 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.240]:57898 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20034237AbYALUke (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Jan 2008 20:40:34 +0000
Received: by an-out-0708.google.com with SMTP id d26so357188and.64
        for <linux-mips@linux-mips.org>; Sat, 12 Jan 2008 12:40:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ekxrB6WPXo2tXThk7f9GIetdRHImOtqrqP+XiQChU6E=;
        b=dXAjDE/hF/fa7cEp67sfqDg4VYwR4dzqKJBD7sceK9s0whV3bO+PY1AWfwDL8sHJHyZKCkC7XayNeZ0/mMdgEhduo8YA1NGkCVXS+Ad+9eUahHn6MCKx6PMGUg9qp1yPOC3W6Waktk4m4/6Zb699tQghXesi7dfQyHI7BL9mrf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SVy07FQPsAcRpZfEg/oy4WPHKdQ+KtZx8l76ytAnXK5GdRpq0wcUGaVqHTWL+AX+gEMrXFgAcHvKbOZ0yr1IUivG+RW+DHImgRjLjPk2YmXIxOtdii95/VKnVHd8+wPPG6AKsAa5My4Z7DMsr4Jjrj7dUo/rernuwVlT3vCFM+U=
Received: by 10.100.231.16 with SMTP id d16mr10088589anh.64.1200170432867;
        Sat, 12 Jan 2008 12:40:32 -0800 (PST)
Received: by 10.100.163.14 with HTTP; Sat, 12 Jan 2008 12:40:32 -0800 (PST)
Message-ID: <acd2a5930801121240o164f0d54pf24b3e0b126ae148@mail.gmail.com>
Date:	Sat, 12 Jan 2008 23:40:32 +0300
From:	"Vitaly Wool" <vitalywool@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [patch] pnx8xxx clocksource cleanups
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <4788F6FE.6000803@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4788BAAC.3020908@gmail.com> <4788F6FE.6000803@ru.mvista.com>
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

> > +static inline void timer_ack(void)
> > +{
> > +    write_c0_compare(cpj);
> > +}
>
>     I still don't understand why you need this function at all, and the 'cpj'
> variable as well -- clockevents core will set the comparator to a needed
> value.  Also, I don't see much value in moving that function...

Well, it's explicitly made inline and it has been moved closer to the
calling function.

Vitaly
