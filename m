Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 22:35:59 +0000 (GMT)
Received: from amdext4.amd.com ([IPv6:::ffff:163.181.251.6]:24965 "EHLO
	amdext4.amd.com") by linux-mips.org with ESMTP id <S8225346AbULHWfw>;
	Wed, 8 Dec 2004 22:35:52 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id iB8MZdgc014666;
	Wed, 8 Dec 2004 16:35:39 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (MMS v5.5.3)); Wed, 08 Dec 2004 16:35:26 -0500
Received: from pcsmail.amd.com (pcsmail.amd.com [163.181.41.233]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id iB8MZO8O026659; Wed,
 8 Dec 2004 16:35:24 -0600 (CST)
Received: from amd.com (pb1k77.amd.com [163.181.32.77]) by
 pcsmail.amd.com (8.11.6/8.11.6) with ESMTP id iB8MZNl13156; Wed, 8 Dec
 2004 16:35:23 -0600
Message-ID: <41B781AB.6020001@amd.com>
Date: Wed, 08 Dec 2004 16:35:23 -0600
From: "Eric DeVolder" <eric.devolder@amd.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Karl Lessard" <klessard@sunrisetelecom.com>
cc: "Michael Kelly" <mike@cogcomp.com>,
	"Pete Popov" <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
Subject: Re: Epson13806 performances on Pb1100
References: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com>
 <MAILSERVERt8gsVWDKp0000090f@mailserver.sunrisetelecom.com>
 <6.2.0.14.2.20041208153445.03ed3c70@pop3.cedata.com>
 <MAILSERVER15BOaF2ka0000096e@mailserver.sunrisetelecom.com>
In-Reply-To: <MAILSERVER15BOaF2ka0000096e@mailserver.sunrisetelecom.com>
X-WSS-ID: 6DA95E24383960-01-01
Content-Type: multipart/alternative;
 boundary=------------090401010206010505010201
Return-Path: <eric.devolder@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.devolder@amd.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090401010206010505010201
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit

The SED13506 device is horribly slow (it stalls the processor an 
enormous amount of time) while it accesses external DRAM for screen 
updates. The SED13806 has integrated SDRAM and performs better than the 
SED13506, but not nearly as well as a PCI graphics card. If you were to 
place a scope on the EWAIT# signal, you'll see it asserted a significant 
amount of time during Au accesses to the SED13806; simply put, this is 
the single largest factor in the poor performace you are observing. Your 
empirical tests verify this.

As for the bug/feature, the controller always performs two beats for 
16-bit chip-selects, so it is best to utilize both beats by performing 
32-bit accesses rather than 8 or 16 (in which case one beat is not 
utilized).

Karl Lessard wrote:

>On December 8, 2004 03:37 pm, Michael Kelly wrote:
>  
>
>>KArl,
>>
>>There is a bug (they might call it a feature) that causes the Au1100
>>to perform two accesses when talking to 16-bit peripherals.  The
>>first access is the real one, while the second access has the byte
>>enables off.  But, this means every access creates two cycles on
>>the bus.
>>
>>I am sure of this bug on the standard peripheral bus, and I am pretty
>>sure it still exists when talking via the LCD signals, since the same
>>bus controller is used.
>>
>>MIchael
>>    
>>
>
>Well, that may cause a problem of course. Do you mean that writing 8-bit or 
>16-bits data through a chip select configured for 16-bit data bus will send 
>in fact two write signals? 
>
>If it is the case, then I obviously need to send 32-bit data for every 
>access, since the second write will be used to send the second word (I 
>suppose). Do I understand well?
>
>  
>
>>At 02:38 PM 12/8/2004, Karl Lessard wrote:
>>    
>>
>>>>I've used the chip with the 2.4 kernel/driver to run X and some
>>>>apps. I'm not sure what you mean by high performance -- does X run
>>>>at reasonable speeds?
>>>>        
>>>>
>>>I'm not running X, I've just runned a little application that writes a
>>>number of vertical lines (so pixel per pixel) in a backbuffer and then
>>>blit its content to the screen. Here's an example of one frame:
>>>
>>>__u8 *dest = (__u8*)back_buffer;
>>>memset(dest, 0, back_buffer_size);      /* clear back buffer */
>>>
>>>for (i = 0; i < 500; i++) {                     /* 500 lines */
>>>        for (j = 0; j >= 100; j--) {            /* of 100 pixel each */
>>>                dest[(j * fb_width) + i] = 0xFF;
>>>        }
>>>}
>>>
>>>memcpy(front_buffer, dest, back_buffer_size);  /* copy back_buffer to
>>>front */
>>>
>>>
>>>Benching with 500 frames, I obtain a rate of 8 fps with the backbuffer
>>>residing in video memory. The framerate increase to 31 fps when the
>>>backbuffer is in system memory! And if I do the same test using the
>>>Au1100 lcd controller (which has its front and back buffer in system
>>>memory), It goes up to 66 fps...
>>>
>>>I don't know what's going on when I try to access the 13806 controller,
>>>but it's really too slow. And using the blit engine don't helps much. The
>>>static controller seems to be set correctly. By the way, the DRAM is
>>>refreshing at 96Hz, and my CRT display is refreshing at 66Hz.
>>>
>>>Any Idea? By the way Dan, I've tried the cache trick, but no luck.
>>>
>>>Thanks a lot,
>>>Karl
>>>
>>>      
>>>
>>>>Pete
>>>>
>>>>        
>>>>
>>>>>I would like to know if anyone have encountered this performance
>>>>>problem in the past with this chip.
>>>>>
>>>>>Thanks in advance,
>>>>>Karl
>>>>>          
>>>>>
>>Michael J. Kelly
>>VP Engineering/Marketing
>>Cogent Computer Systems, Inc.
>>1130 Ten Rod Road
>>Suite A-201
>>North Kingstown, RI 02852
>>tel:401-295-6505 fax:401-295-6507
>>www.cogcomp.com
>>alternate email: mkelly6505@hotmail.com
>>    
>>
>
>
>  
>

--------------090401010206010505010201
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
The SED13506 device is horribly slow (it stalls the processor an
enormous amount of time) while it accesses external DRAM for screen
updates. The SED13806 has integrated SDRAM and performs better than the
SED13506, but not nearly as well as a PCI graphics card. If you were to
place a scope on the EWAIT# signal, you'll see it asserted a
significant amount of time during Au accesses to the SED13806; simply
put, this is the single largest factor in the poor performace you are
observing. Your empirical tests verify this.<br>
<br>
As for the bug/feature, the controller always performs two beats for
16-bit chip-selects, so it is best to utilize both beats by performing
32-bit accesses rather than 8 or 16 (in which case one beat is not
utilized).<br>
<br>
Karl Lessard wrote:<br>
<blockquote type="cite"
 cite="midMAILSERVER15BOaF2ka0000096e@mailserver.sunrisetelecom.com">
  <pre wrap="">On December 8, 2004 03:37 pm, Michael Kelly wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">KArl,

There is a bug (they might call it a feature) that causes the Au1100
to perform two accesses when talking to 16-bit peripherals.  The
first access is the real one, while the second access has the byte
enables off.  But, this means every access creates two cycles on
the bus.

I am sure of this bug on the standard peripheral bus, and I am pretty
sure it still exists when talking via the LCD signals, since the same
bus controller is used.

MIchael
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, that may cause a problem of course. Do you mean that writing 8-bit or 
16-bits data through a chip select configured for 16-bit data bus will send 
in fact two write signals? 

If it is the case, then I obviously need to send 32-bit data for every 
access, since the second write will be used to send the second word (I 
suppose). Do I understand well?

  </pre>
  <blockquote type="cite">
    <pre wrap="">At 02:38 PM 12/8/2004, Karl Lessard wrote:
    </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">I've used the chip with the 2.4 kernel/driver to run X and some
apps. I'm not sure what you mean by high performance -- does X run
at reasonable speeds?
        </pre>
      </blockquote>
      <pre wrap="">I'm not running X, I've just runned a little application that writes a
number of vertical lines (so pixel per pixel) in a backbuffer and then
blit its content to the screen. Here's an example of one frame:

__u8 *dest = (__u8*)back_buffer;
memset(dest, 0, back_buffer_size);      /* clear back buffer */

for (i = 0; i &lt; 500; i++) {                     /* 500 lines */
        for (j = 0; j &gt;= 100; j--) {            /* of 100 pixel each */
                dest[(j * fb_width) + i] = 0xFF;
        }
}

memcpy(front_buffer, dest, back_buffer_size);  /* copy back_buffer to
front */


Benching with 500 frames, I obtain a rate of 8 fps with the backbuffer
residing in video memory. The framerate increase to 31 fps when the
backbuffer is in system memory! And if I do the same test using the
Au1100 lcd controller (which has its front and back buffer in system
memory), It goes up to 66 fps...

I don't know what's going on when I try to access the 13806 controller,
but it's really too slow. And using the blit engine don't helps much. The
static controller seems to be set correctly. By the way, the DRAM is
refreshing at 96Hz, and my CRT display is refreshing at 66Hz.

Any Idea? By the way Dan, I've tried the cache trick, but no luck.

Thanks a lot,
Karl

      </pre>
      <blockquote type="cite">
        <pre wrap="">Pete

        </pre>
        <blockquote type="cite">
          <pre wrap="">I would like to know if anyone have encountered this performance
problem in the past with this chip.

Thanks in advance,
Karl
          </pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <pre wrap="">Michael J. Kelly
VP Engineering/Marketing
Cogent Computer Systems, Inc.
1130 Ten Rod Road
Suite A-201
North Kingstown, RI 02852
tel:401-295-6505 fax:401-295-6507
<a class="moz-txt-link-abbreviated" href="http://www.cogcomp.com">www.cogcomp.com</a>
alternate email: <a class="moz-txt-link-abbreviated" href="mailto:mkelly6505@hotmail.com">mkelly6505@hotmail.com</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------090401010206010505010201--
