Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DLNTE14547
	for linux-mips-outgoing; Thu, 13 Sep 2001 14:23:29 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DLNPe14544
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 14:23:25 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA16591;
	Thu, 13 Sep 2001 14:23:15 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id OAA01164;
	Thu, 13 Sep 2001 14:23:15 -0700 (PDT)
Received: from kjelde (coppckbe [172.17.85.2])
	by copfs01.mips.com (8.11.4/8.9.0) with SMTP id f8DLNEa29507;
	Thu, 13 Sep 2001 23:23:15 +0200 (MEST)
From: "Kjeld Borch Egevang" <kjelde@mips.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Error in gcc version 2.96 20000731
Date: Thu, 13 Sep 2001 23:22:46 +0200
Message-ID: <NFBBKGGKGLLGNBGCEPKIKEHDCAAA.kjelde@mips.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010913141454.A30909@lucon.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I get your point. A bit suprising though. Do you consider it a bug?

/Kjeld

-----Original Message-----
From: owner-linux-mips@oss.sgi.com
[mailto:owner-linux-mips@oss.sgi.com]On Behalf Of H . J . Lu
Sent: 13. september 2001 23:15
To: Kjeld Borch Egevang
Cc: linux-mips@oss.sgi.com
Subject: Re: Error in gcc version 2.96 20000731


On Thu, Sep 13, 2001 at 11:09:04PM +0200, Kjeld Borch Egevang wrote:
> Perhaps I don't get you point, but I get the same with:
> 
> int main()
> {
>   rtx rt;
> 
>   put_code(&rt, (short)5);
>   printf("gen_rtx, code=%d\n", (int)rt.code);
> }
> 

That is not what I meant. You have

typedef struct rtx_def
{
  short code;
  int dummy;
} rtx;
 
The first field of rtx_def is short.

  for (; length >= 0; length--)
    ((int *) rt)[length] = 0;

But you access it as int. If you do

  for (; length >= 0; length--)
    ((short *) rt)[length] = 0;

It will be ok.


H.J.
