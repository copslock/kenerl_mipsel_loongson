Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 20:41:08 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:4787
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225351AbVAUUlC>; Fri, 21 Jan 2005 20:41:02 +0000
Received: (qmail 27275 invoked from network); 21 Jan 2005 03:09:34 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 21 Jan 2005 03:09:34 -0800
Message-ID: <41F168DA.60301@total-knowledge.com>
Date:	Fri, 21 Jan 2005 12:40:58 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
CC:	linux-mips@linux-mips.org
Subject: Re: O2 and 128Mb
References: <1105602134.10493.23.camel@localhost>	 <41E627F8.3010004@total-knowledge.com>	 <1105605285.10490.52.camel@localhost>	 <41E6CB5B.6080303@total-knowledge.com> <1106338775.4760.17.camel@localhost>
In-Reply-To: <1106338775.4760.17.camel@localhost>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

drop the console=tty0 part

Giuseppe Sacco wrote:

>Il giorno gio, 13-01-2005 alle 11:26 -0800, Ilya A. Volynets-Evenbakh ha
>scritto:
>  
>
>>Please set up serial console, and find out where kernel crashes.
>>It is pretty obvious that happens before gbefb is initialized, but
>>after ip32-reset is setup (which sets up timer to blink the LED),
>>thus should be able to give you some output on serial port.
>>    
>>
>
>Sorry for being late,
>I tried: I found a laptop equipped with serial port, plugged a nullmodem
>serial cable on the laptop serial port and on the serial port labeled "1"
>of the O2 machine. I started minicom on the laptop and selected ttyS0, 9600,
>8bit, noparity, 1 stop bit.
>
>Then changed in /etc/arcboot.conf, my append line from
>append="root=/dev/sda1" to
>append="root=/dev/sda1 console=ttyS0,9600n8 console=tty0"
>
>shutdown the O2, unplugged power cable, waited, plugged, swithed on.
>Then I changed the OSLoadFilename correctly, and typed "boot".
>
>During the supposed boot, minicom doesn't display *any* character. It
>just change the online label from "00:00" to "00:01". Nothing more,
>
>Then, as already explained, the red led on the SGI O2 starts blinking.
>
>I then tried the same "append" line with my working kernel and it worked
>as expected: writing to both the serial console and the O2 screen.
>
>How may I better debug the problem? Anyone have a working kernel or,
>maybe, a newer arcboot?
>
>Thanks,
>Giuseppe
>
>Il giorno gio, 13-01-2005 alle 11:26 -0800, Ilya A. Volynets-Evenbakh ha
>scritto:
>  
>
>>Please set up serial console, and find out where kernel crashes.
>>It is pretty obvious that happens before gbefb is initialized, but
>>after ip32-reset is setup (which sets up timer to blink the LED),
>>thus should be able to give you some output on serial port.
>>
>>Oh, and what does it have to do with fact you have 128M of RAM?
>>Giuseppe Sacco wrote:
>>
>>    
>>
>>>Il giorno mer, 12-01-2005 alle 23:49 -0800, Ilya A. Volynets-Evenbakh ha
>>>scritto:
>>> 
>>>
>>>      
>>>
>>>>"Cannot boot" is not very good describtion of the problem.
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>You are right.
>>>Arcboot is Debian version 0.3.8.4. I select the stanza arcboot should
>>>use, with 'setenv OSLoadFilename <stanza>" and the kernel is loaded.
>>>Then it s ran and the only change I see is the red led blinking. The
>>>screen messages are:
>>>
>>>Loading program segment 1 at 0x80004000, offset=0x4000, size = 0x3df086
>>>Zeroing memory at 0x803e3086, size = 0x2bf9a
>>>Starting 32-bit kernel
>>>
>>>Bye,
>>>Giuseppe
>>>      
>>>

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
