Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 01:28:10 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:23013 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20023950AbXFTA2I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 01:28:08 +0100
Received: (qmail 7944 invoked by uid 101); 20 Jun 2007 00:28:00 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 20 Jun 2007 00:28:00 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5K0Rxdl008483;
	Tue, 19 Jun 2007 17:27:59 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW7HY4>; Tue, 19 Jun 2007 17:27:59 -0700
Message-ID: <4678748B.8090403@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-mips@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	Dan Doucette <Dan_Doucette@pmc-sierra.com>
Subject: Re: [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
Date:	Tue, 19 Jun 2007 17:27:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 20 Jun 2007 00:27:56.0238 (UTC) FILETIME=[D9071EE0:01C7B2D1]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> On Fri, 15 Jun 2007 14:46:03 -0600
> Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> 
>  > [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
>  >
>  > Patch to add a GPIO char driver for the PMC-Sierra MSP71xx devices.
> 

>  > ...
>  >
>  > +/* Maps 'basic' pins to relative offset from 0 per register */
>  > +static int const MSP_GPIO_OFFSET[] = {
>  > +     /* GPIO 0 and 1 on the first register */
>  > +     0, 0,
>  > +     /* GPIO 2, 3, 4, and 5 on the second register */
>  > +     2, 2, 2, 2,
>  > +     /* GPIO 6, 7, 8, and 9 on the third register */
>  > +     6, 6, 6, 6,
>  > +     /* GPIO 10, 11, 12, 13, 14, and 15 on the fourth register */
>  > +     10, 10, 10, 10, 10, 10,
>  > +};
> 
> This shouldn't be in a header file.  Because each compilation unit which
> includes this header will (potentially) get its own copy of the data.
> 
> That includes any userspace apps which include this header(!)

There are other drivers which use these macros irrespective of the char
driver being compiled in or not. I can't move this to the driver .c file
as all the macros will become useless.

>  > +/* This gives you the 'register relative ofet gpio' number */
>  > +#define OFFSET_GPIO_NUMBER(gpio)     (gpio - MSP_GPIO_OFFSET[gpio])
>  > +
>  > +/* These take the 'register relative offset gpio' number */
>  > +#define BASIC_MODE_REG_SHIFT(ogpio)  (ogpio * 4)
>  > +#define BASIC_MODE_REG_VALUE(mode, ogpio) \
>  > +                     (mode << BASIC_MODE_REG_SHIFT(ogpio))
>  > +#define BASIC_MODE_REG_MASK(ogpio) \
>  > +                     BASIC_MODE_REG_VALUE(0xf, ogpio)
>  > +#define BASIC_DATA_REG_MASK(ogpio)   (1 << ogpio)
>  > +
>  > +/* These take the actual GPIO number (0 through 15) */
>  > +#define BASIC_DATA_MASK(gpio) \
>  > +             BASIC_DATA_REG_MASK(OFFSET_GPIO_NUMBER(gpio))
>  > +#define BASIC_MODE_MASK(gpio) \
>  > +             BASIC_MODE_REG_MASK(OFFSET_GPIO_NUMBER(gpio))
>  > +#define BASIC_MODE(mode, gpio) \
>  > +             BASIC_MODE_REG_VALUE(mode, OFFSET_GPIO_NUMBER(gpio))
>  > +#define BASIC_MODE_SHIFT(gpio) \
>  > +             BASIC_MODE_REG_SHIFT(OFFSET_GPIO_NUMBER(gpio))
>  > +#define BASIC_MODE_FROM_REG(data, gpio)      \
>  > +             BASIC_MODE_REG_FROM_REG(data, OFFSET_GPIO_NUMBER(gpio))
>  > +
>  > +/* This gives you the 'register relative offset gpio' number */
>  > +#define EXTENDED_OFFSET_GPIO(gpio)   (gpio - 16)
>  > +
>  > +/* These take the 'register relative offset gpio' number */
>  > +#define EXTENDED_REG_DISABLE(ogpio)  (0x2 << ((ogpio * 2) + 16))
>  > +#define EXTENDED_REG_ENABLE(ogpio)   (0x1 << ((ogpio * 2) + 16))
>  > +#define EXTENDED_REG_SET(ogpio)              (0x2 << (ogpio * 2))
>  > +#define EXTENDED_REG_CLR(ogpio)              (0x1 << (ogpio * 2))
>  > +
>  > +/* These take the actual GPIO number (16 through 19) */
>  > +#define EXTENDED_DISABLE(gpio) \
>  > +             EXTENDED_REG_DISABLE(EXTENDED_OFFSET_GPIO(gpio))
>  > +#define EXTENDED_ENABLE(gpio) \
>  > +             EXTENDED_REG_ENABLE(EXTENDED_OFFSET_GPIO(gpio))
>  > +#define EXTENDED_SET(gpio) \
>  > +             EXTENDED_REG_SET(EXTENDED_OFFSET_GPIO(gpio))
>  > +#define EXTENDED_CLR(gpio) \
>  > +             EXTENDED_REG_CLR(EXTENDED_OFFSET_GPIO(gpio))
> 
> inlined functions are preferred over macros.  Only use macros when for some
> reason you *must* use macros.

Even for simple macros that have a single +, - or << ?

I thought there was an advantage to using macros, allowing the compiler to
combine a series of simple macro calls into a single constant.

Marc
