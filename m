Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 21:42:04 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:63383 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225213AbTHBUl7>; Sat, 2 Aug 2003 21:41:59 +0100
Received: from gentoo.org (pcp02545003pcs.waldrf01.md.comcast.net[68.48.92.102](untrusted sender))
          by comcast.net (sccrmhc12) with SMTP
          id <20030802204152012005ke30e>
          (Authid: kumba12345);
          Sat, 2 Aug 2003 20:41:52 +0000
Message-ID: <3F2C2217.5010006@gentoo.org>
Date: Sat, 02 Aug 2003 16:41:59 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: udelay
References: <Pine.GSO.4.21.0308021401150.543-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308021401150.543-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:

> Any kernel messages (e.g. transmit timed out) from the tulip driver when it
> dies?

None that I can see.  If I'm using SSH, input/output just stops cold. 
In some cases, I have noticed that if you send a single character (like 
you were in a text editor when input/output died), and you wait a minute 
or so, it will appear.  This seems to mean the interface hasn't died 
completely, but seems to havce slowed down to the point of complete 
unsuability, like >1bps would be my guess.

Restarting the interface fixes it for several seconds until it drops 
again.  I usually disconnect from the serial console before trying any 
SSH activity, as serial console work + network activity can halt the 
kernel (which I have confirmed does occur in 2.4.21 CVS).

As an experiment, I did try replacing the udelay(1000) line in the 
cobalt patch with mdelay(1) to see if this udelay() brokeness was the 
issue, but it still drops out after several seconds.

--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
