Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 20:37:18 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:18195 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037600AbXJOThJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 20:37:09 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1356540nfd
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2007 12:36:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=qOPllCOmPWxHHHe8Zal/cb3NU26XR9+bFfn50dmzFZA=;
        b=V7ZaJW928h1sxpWmIyZYlTa3ymULdEYsQHF2xOC02MNt8mYO2ypAlpWGaMxZLd++ilbqkwXf+jvSeMBsz6hFVBIYX1OVmepyrNQbYiMGiFHU84eaml50qeXHUxL6dkGvnUEtQrcQWjSKUnqXxB8yp9tMK5THEdUUGiqWQCI+6aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aSVRR2KGELTQnNz39jDsjzXEzBsrDhvxaXBiBMGll/pwrwMRnoyaYia13WuEgrBBsZ5qsRoseBTc98k7/qeKRR8F9/wcy0OZ5//lmaYt4xNkR74u1GVe5MZIM2tgr5v2Tmf1jwLbV9JXoz6nm/RO4feBLNxSpqxUv8VNTL3bEyg=
Received: by 10.86.51.2 with SMTP id y2mr5200995fgy.1192477011771;
        Mon, 15 Oct 2007 12:36:51 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id b17sm8604048fka.2007.10.15.12.36.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Oct 2007 12:36:51 -0700 (PDT)
Message-ID: <4713C11F.3010903@gmail.com>
Date:	Mon, 15 Oct 2007 21:35:59 +0200
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
X-archive-position: 17055
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

OK, I give it a try and here are some figures:

$ mipsel-linux-size mipssde-6.05.00-20061023/vmlinux~*
   text    data     bss     dec     hex filename
1446130   58456   93056 1597642  1860ca mipssde-6.05.00-20061023/vmlinux~4ksd
1472034   58456   93056 1623546  18c5fa mipssde-6.05.00-20061023/vmlinux~mips32r2-smartmips
1446130   58456   93056 1597642  1860ca mipssde-6.05.00-20061023/vmlinux~mips32r2-smartmips-mtune4ksd

So you're right "-march=mips32r2 -smartmips -mtune=4ksd" gives the
same result as "-march=4ksd"

And the extra space given by "-march=mips32r2 -smartmips" is coming
from some additional nop instructions:

$ mipsel-linux-objdump -D vmlinux~mips32r2-smartmips > vmlinux~mips32r2-smartmips.S
$ mipsel-linux-objdump -D vmlinux~4ksd > vmlinux~4ksd.S
$ grep -c nop *.S
vmlinux~4ksd.S:18708
vmlinux~mips32r2-smartmips.S:27895

It seems that these extra nops are used for load delays. For example:

vmlinux~4ksd.S:
--------------
<snip>
c00008b4:      8fa40040        lw      a0,64(sp)
c00008b8:      27a40018        addiu   a0,sp,24
c00008bc:      0c000148        jal     c0000520 <try_name>
<snip>

vmlinux~mips32r2-smartmips.S:
---------------------------
c00008b8:      8fa40040        lw      a0,64(sp)
c00008bc:      00000000        nop
c00008c0:      27a40018        addiu   a0,sp,24
c00008c4:      0c000148        jal     c0000520 <try_name>

		Franck
