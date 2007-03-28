Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 08:38:44 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.239]:41209 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021871AbXC1Hik (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 08:38:40 +0100
Received: by wr-out-0506.google.com with SMTP id 58so1087207wri
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 00:37:39 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V5xQmAGsFIacFNsBdjufXFG4jRd9dM5MYISsf/SJJnz/tFwYFHGN3oH3kXk9PCowUmbtXHMcRPoN8nhttewVzSgpzFs3fjMaio2sDc/oxa7BflVxLKMdx6RuUgS7z+KPAYg8RydRsNx/j0sNSvGfuccZLgHXqrAqMp8sfWPyqdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fsq23VgQf2ej4V44MiBOSN7bhcK3QcJA3VPoC1U1hDfJ4DBODSdlRWjXOAz6k+JwlIfiXBLLlFStcRr1lLzYq5eeiRXNWNI1rz0GebsMPhoSCLlyPRmkP679baUD7Y0fLdQt38NYEhW3tMqSDJoynafSDsN7lzsdkALEje7Esvc=
Received: by 10.114.201.1 with SMTP id y1mr3564922waf.1175067459374;
        Wed, 28 Mar 2007 00:37:39 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Wed, 28 Mar 2007 00:37:39 -0700 (PDT)
Message-ID: <cda58cb80703280037s72964594jccab64866a54c4a6@mail.gmail.com>
Date:	Wed, 28 Mar 2007 09:37:39 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Early printk recent changes.
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Linux MIPS List" <linux-mips@linux-mips.org>
In-Reply-To: <20070327175733.GA26496@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com>
	 <Pine.LNX.4.64N.0703271526000.5547@blysk.ds.pg.gda.pl>
	 <cda58cb80703270803g7c1119e4w22272e9e18c0d251@mail.gmail.com>
	 <Pine.LNX.4.64N.0703271620080.5547@blysk.ds.pg.gda.pl>
	 <cda58cb80703270906j74d6bf6fsb6259f24427faff5@mail.gmail.com>
	 <20070327175733.GA26496@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/27/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> loose ends in the code than before.  And since we're always in the trade
> of better mouse trap I certainly won't object if submits has one :-)
>

since you agree to consider them, I'll do that shortly.
-- 
               Franck
