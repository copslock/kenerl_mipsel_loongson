Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DLExt14349
	for linux-mips-outgoing; Thu, 13 Sep 2001 14:14:59 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DLEve14344
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 14:14:57 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 74A78125C3; Thu, 13 Sep 2001 14:14:54 -0700 (PDT)
Date: Thu, 13 Sep 2001 14:14:54 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Error in gcc version 2.96 20000731
Message-ID: <20010913141454.A30909@lucon.org>
References: <20010913081040.A24910@lucon.org> <NFBBKGGKGLLGNBGCEPKIEEHDCAAA.kjelde@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NFBBKGGKGLLGNBGCEPKIEEHDCAAA.kjelde@mips.com>; from kjelde@mips.com on Thu, Sep 13, 2001 at 11:09:04PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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
