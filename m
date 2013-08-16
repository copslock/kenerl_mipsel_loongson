Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 10:26:18 +0200 (CEST)
Received: from mail.active-venture.com ([67.228.131.205]:59175 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6830580Ab3HPI0OWx0-d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 10:26:14 +0200
Received: (qmail 31100 invoked by uid 399); 16 Aug 2013 08:26:06 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 16 Aug 2013 08:26:06 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <520DE21D.8000905@roeck-us.net>
Date:   Fri, 16 Aug 2013 01:26:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [ 00/17] 3.4.58-stable review
References: <20130813063501.728847844@linuxfoundation.org> <520A1D56.2050507@roeck-us.net> <20130813175858.GC7336@kroah.com> <20130813201936.GA18358@roeck-us.net> <20130815063158.GB25754@kroah.com> <520C86BD.2020903@roeck-us.net> <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com> <520DB045.7000309@roeck-us.net> <20130816051041.GA23784@kroah.com>
In-Reply-To: <20130816051041.GA23784@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 08/15/2013 10:10 PM, Greg Kroah-Hartman wrote:
[ .. ]

>> three to go (arm:allmodconfig, sparc32:defconfig, and sparc64:allmodconfig).
>

Please add (in this order) the following patches to 3.4.

de36e66d5f sparc32: add ucmpdi2
74c7b28953 sparc32: Add ucmpdi2.o to obj-y instead of lib-y.

This fixes the sparc32:defconfig build error.

Thanks,
Guenter
