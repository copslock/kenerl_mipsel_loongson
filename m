Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:20:50 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:38049 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022087AbXJIUUm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:20:42 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1323819nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:20:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=CW3hLTrKrKfGQAFKGRXrvTOOhS1usIbfwtC6yXxO9oo=;
        b=jN7uOUGr94tYTMd3APfSxFSjEb3mi7LafFNOFOYiuyC31HDXA8iQwsUWFUnaaaG8OGOnUHIDEplkI7MVZZw1HunnuZdH5z/U6MMmX7gGTpIUIOI0un1Ey95bLhNtYkxQnSk8tcXfKLON7GHyw1Zw/M56xdVsBHcml5ZZP9nDT0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qF4UgqB/ZR2dveetDMfiA1yzhk6BYDXxQ5gP/JevWyI2eVLQmEB+lHjw0OJcEQnpCRtpx62L/SjKW5R5OTekont2dBa4SXWKDoxs2v7tZS/rqshwxT8rW4zWL2xIBVmOyqyI0ySftmG44hnkP1c/sl1qiQn4AzxFCLyYFg68sm4=
Received: by 10.86.80.5 with SMTP id d5mr6295224fgb.1191961224532;
        Tue, 09 Oct 2007 13:20:24 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 22sm14366850fkr.2007.10.09.13.20.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:20:23 -0700 (PDT)
Message-ID: <470BE276.8050200@gmail.com>
Date:	Tue, 09 Oct 2007 22:20:06 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64.0710051102300.32066@anakin> <470A4673.30604@gmail.com> <Pine.LNX.4.64.0710081720550.1416@anakin>
In-Reply-To: <Pine.LNX.4.64.0710081720550.1416@anakin>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> Can't you currently compile a kernel that run on e.g. all O2s,
> irrespective of the actual CPU type?
> 

It seems so, I've just been teached about it actually. So I think
we just have to stick with tlbex.c and perhaps make it smaller...

Thanks,
		Franck
