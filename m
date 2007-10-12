Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 07:37:05 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:58613 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025269AbXJLGg4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 07:36:56 +0100
Received: by nf-out-0910.google.com with SMTP id c10so686305nfd
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 23:36:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=g4jU8sXuxUJXtiFTOSU3A/zmTIQ3VRA+DflgdgL3bdY=;
        b=FPEK29Splymzx0sD92LJNdYmg8BFjryhipbF50nHf4NZ24TmLdvxiNYDiuzNGwRXQx8rva07MDvQYXPJJKHA4t5vrP6HpEsNUIX1q8tyFCnzhYm9JM6phLZOVU12XHJeDIuCO3672fvZPPsOm3DYNa9aGCnpD4FwjArAzcbh2qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KzpIxCbVdnnw+3NgpejSwJDpHv5WUs4HCUmZj4GSByOTprUBBVrZaXsRhVWZLZbzCwohvS/5cfVLwbn0qQVPYworSN/cHGNsmaQ8LTnlrE2RKkB3cgkjjX1Z3HQS+PIFT6LOr6KvV92aAqhxfwtvIKysYgCKvzkLCRkYE9TlW34=
Received: by 10.86.9.8 with SMTP id 8mr2098415fgi.1192170999078;
        Thu, 11 Oct 2007 23:36:39 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 31sm605567fkt.2007.10.11.23.36.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 23:36:37 -0700 (PDT)
Message-ID: <470F15D7.1010106@gmail.com>
Date:	Fri, 12 Oct 2007 08:36:07 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] tlbex.c: Cleanup __init usages.
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com> <470BE5D2.50101@gmail.com> <20071011161654.GB12782@linux-mips.org>
In-Reply-To: <20071011161654.GB12782@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> So I applied this one only while we sort out the .init.bss stuff.
> 

Could you drop this one too ?

The patchset I sent was badly ordered I should have put clean up
stuffs first then optimization stuff.

I'm going to resend a pachset that deals with clean up only.

Thanks,
		Franck
