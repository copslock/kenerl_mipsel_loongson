Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 17:26:45 +0000 (GMT)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:33470
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225284AbVBUR03>; Mon, 21 Feb 2005 17:26:29 +0000
Received: from unknown (HELO ?10.2.2.62?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 21 Feb 2005 17:26:26 -0000
Message-ID: <421A19B6.6050102@embeddedalley.com>
Date:	Mon, 21 Feb 2005 09:26:14 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [patch]small bug in PCMCIA on DB1x00 boards
References: <200502211609.42963.eckhardt@satorlaser.com>
In-Reply-To: <200502211609.42963.eckhardt@satorlaser.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Hello!
> 
> Another patch that fixes some small glitches in the PCMCIA code.
> 
> Note: I have not (yet) been able to get the compact-flash card to be 
> recognised on my board (it is supposed to appear as PCMCIA/IDE device, 
> right?) but this patch addresses three things that should be obvious without 
> testing. Yes, I know, those are famous last words, but look yourselves. ;)
> 
> BTW: I found that au1000_xxs1500.c and au1000_pb1x00.c can't compile due 
> changed PCMCIA interfaces,

I've updated the db1x00 driver only. It should be easy to update the 
rest of the boards, using the db1x as an example.

Pete

  some functions (socket_state, configure_socket)
> were changed from returning void to returning int and changed their 
> parameters. These two are also the last two files that use struct 
> pcmcia_configure. Maybe copying that struct to the .c files and adding an 
> #error with a proper comment would be a good idea?
> 
> Uli
> 
> 
> Changes:
>  * removed struct pcmcia_irqs, which was unused
>  * added an explicit BUG() in a place marked with "should never happen"
>  * added a missing early return when the card-voltage could not be
>    detected, as a comment above already says.
> 
> ---
> 
> Index: au1000_db1x00.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/pcmcia/au1000_db1x00.c,v
> retrieving revision 1.6
> diff -u -r1.6 au1000_db1x00.c
> --- au1000_db1x00.c 14 Oct 2004 06:24:25 -0000 1.6
> +++ au1000_db1x00.c 21 Feb 2005 14:13:21 -0000
> @@ -91,7 +91,9 @@
>    vs = (bcsr->status & 0xC)>>2;
>    inserted = !(bcsr->status & (1<<5));
>    break;
> - default:/* should never happen */
> + default:
> +  /* should never happen */
> +  BUG();
>    return;
>   }
>  
> @@ -109,8 +111,8 @@
>      break;
>     default:
>      /* return without setting 'detect' */
> -    printk(KERN_ERR "db1x00 bad VS (%d)\n",
> -      vs);
> +    printk(KERN_ERR "db1x00 bad VS (%d)\n", vs);
> +    return;
>    }
>    state->detect = 1;
>    state->ready = 1;
> Index: au1000_generic.h
> ===================================================================
> RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.h,v
> retrieving revision 1.4
> diff -u -r1.4 au1000_generic.h
> --- au1000_generic.h 19 Oct 2004 07:26:37 -0000 1.4
> +++ au1000_generic.h 21 Feb 2005 14:13:21 -0000
> @@ -78,13 +78,6 @@
>            reset: 1;
>  };
>  
> -struct pcmcia_irqs {
> - int sock;
> - int irq;
> - const char *str;
> -};
> -
> -
>  struct au1000_pcmcia_socket {
>   struct pcmcia_socket socket;
>  
> 
> 
