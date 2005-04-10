Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2005 20:28:20 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.200]:44485 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225977AbVDJT2F>;
	Sun, 10 Apr 2005 20:28:05 +0100
Received: by wproxy.gmail.com with SMTP id 57so1054816wri
        for <linux-mips@linux-mips.org>; Sun, 10 Apr 2005 12:27:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Gbi+cOPjXhggOV2k2QYT70u2rJZ+vCIjiRBNWrzcaFvMh6wdNNcqHEunXzPN8qxNkbEKoltJIHDZLfnAUA6SNvRj2V7W5r15qpIV21oxJgaihD/jUzFibpnRxXOZPY9Yp1d8HOhrtRODBeUiDpHKfps1hrBs9Z3xRSzyWKo3dZ8=
Received: by 10.54.71.15 with SMTP id t15mr2852940wra;
        Sun, 10 Apr 2005 12:27:58 -0700 (PDT)
Received: by 10.54.38.20 with HTTP; Sun, 10 Apr 2005 12:27:58 -0700 (PDT)
Message-ID: <e02bc661050410122733e21927@mail.gmail.com>
Date:	Sun, 10 Apr 2005 21:27:58 +0200
From:	Sergio Ruiz <quekio@gmail.com>
Reply-To: Sergio Ruiz <quekio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Linking assembled PIC code with Linux libc library
In-Reply-To: <e02bc66105041012091afdf306@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e02bc66105040905091efb3dc6@mail.gmail.com>
	 <20050409134919.GA4738@nevyn.them.org>
	 <e02bc661050409113820cceae3@mail.gmail.com>
	 <20050409215140.GA15253@nevyn.them.org>
	 <e02bc66105041012091afdf306@mail.gmail.com>
Return-Path: <quekio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quekio@gmail.com
Precedence: bulk
X-list: linux-mips

But if I use GCC with my assembler code, and I use a simple 'printf'
function, the assembler code I get is totally different than the
original one, so I cant debug it.

any other possibility?

thanks,

Sergio
