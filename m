Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 20:54:45 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:44147 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225194AbTCUUyo> convert rfc822-to-8bit;
	Fri, 21 Mar 2003 20:54:44 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 9C62D720; Fri, 21 Mar 2003 21:54:20 +0100 (CET)
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Success! Full CardBus/EXCA on PCI->Cardbus Bridge + DbAU1500
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <1048273049.14211.56.camel@zeus.mvista.com> (Pete Popov's
 message of "21 Mar 2003 10:57:29 -0800")
References: <20030314122352.F20129@luca.pas.lab>
	<1047677667.18887.162.camel@zeus.mvista.com>
	<20030314135721.G20129@luca.pas.lab>
	<1048273049.14211.56.camel@zeus.mvista.com>
Date: Fri, 21 Mar 2003 21:54:20 +0100
Message-ID: <86n0jophj7.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "pete" == Pete Popov <ppopov@mvista.com> writes:

Hi
>> Index: io.h
>> ===================================================================
>> RCS file: /home/cvs/linux/include/asm-mips/io.h,v
>> retrieving revision 1.29.2.20
>> diff -u -r1.29.2.20 io.h
>> --- io.h        25 Feb 2003 22:03:12 -0000      1.29.2.20
>> +++ io.h        14 Mar 2003 21:50:14 -0000
>> @@ -332,12 +332,25 @@
>> SLOW_DOWN_IO;                                                   \
>> } while(0)
>> °
>> -#define outw_p(val,port)                                               \
>> -do {                                                                   \
>> -       *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
>> -               __ioswab16(val);                                        \
>> -       SLOW_DOWN_IO;                                                   \
>> -} while(0)
>> +/* baitisj */
>> +static inline u16 outw_p(u16 val, unsigned long port)
>> +{
>> +    register u16 retval;
>> +    do {
>> +        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
>> +            __ioswab16(val);
>> +        SLOW_DOWN_IO;
>> +    } while(0);
>> +    return retval;
>> +}

static inline u16 outw_p(u16 val, unsigned long port)
{
        u16 retval; 
        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
               __ioswab16(val);
               SLOW_DOWN_IO;
        return retval;
}

while do construct inside a function shouldn't be needed when you have
a function.  And register is obsolete :)

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
