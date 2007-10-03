Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 20:48:06 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:50520 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20025725AbXJCTr6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 20:47:58 +0100
Received: by ug-out-1314.google.com with SMTP id u2so235577uge
        for <linux-mips@linux-mips.org>; Wed, 03 Oct 2007 12:47:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=wBaLFP0lfnx1FAcT4YjMW+TTCpdClKW+ZrInFq4+dFM=;
        b=iPJqUHkDG+ZJiAZ6EefglT1ypwYvQ6xz9SbA1VyhMjqsDDRBeV7UvIPq5RFaYQRK1UCstnt9tdN2lisiiHb93DEqH0SJh0JoaXYej4hFFcK01/NPewOuxcyBsA21QPmq//8xEH+JCcVqyIvpdmmJV6CXQQ6/eXhfqAfdB/tb2n8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Kv8FL0QGhqc8/6QlWbT98A3vyXVGw12A2snQuxFj/rMSn806nWhAwt7bu7DfD3S6/qN4r7XD8hhUQqS9rWq8EQlFYFH2aVGaKSgMS9N0bjwudc0i3kEjUaFZZLOwf+TfS32K+0ahK297ikJPWhIrPGuemnwUe3+ww8IPCEQ1H9Q=
Received: by 10.66.243.2 with SMTP id q2mr1007918ugh.1191440877532;
        Wed, 03 Oct 2007 12:47:57 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id w7sm1506880mue.2007.10.03.12.47.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Oct 2007 12:47:56 -0700 (PDT)
Message-ID: <4703F155.4000301@gmail.com>
Date:	Wed, 03 Oct 2007 21:45:25 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
In-Reply-To: <20071003131158.GL16772@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> 
> Then you have the worst of both approaches: The nicely readable
> disassembly will change under you feet, and you still need
> relocation annotations etc. for CPU-specific fixups. The end-result
> is likely more complicated and opaque than what we have now.

Let say we generate handlers with all possible cpu fixups. Very few
instructions would be removed so the disassembly should be quite
similar after patching. And by emitting some nice comments in the
generated code, it should be fairly obvious to get an idea of the
final code.

All fixups would be listed in a table with some flags to identify them
and a list of instructions which need to be relocated.

It seems to me that the kernel code would be much simpler than what we
have now. Regarding the script used to generate the assembly code, if
think it would be too.

Thanks,
		Franck
