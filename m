Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 15:07:48 +0000 (GMT)
Received: from rtp-iport-1.cisco.com ([IPv6:::ffff:64.102.122.148]:36766 "EHLO
	rtp-iport-1.cisco.com") by linux-mips.org with ESMTP
	id <S8225221AbVASPHn>; Wed, 19 Jan 2005 15:07:43 +0000
Received: from rtp-core-1.cisco.com (64.102.124.12)
  by rtp-iport-1.cisco.com with ESMTP; 19 Jan 2005 10:21:43 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Received: from mira-kan-a.cisco.com (IDENT:mirapoint@mira-kan-a.cisco.com [161.44.201.17])
	by rtp-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j0JF7XW0022734
	for <linux-mips@linux-mips.org>; Wed, 19 Jan 2005 10:07:33 -0500 (EST)
Received: from [161.44.199.214] (dhcp-kta2-161-44-199-214.cisco.com [161.44.199.214])
	by mira-kan-a.cisco.com (MOS 3.4.6-GR)
	with ESMTP id AAZ69103;
	Wed, 19 Jan 2005 07:07:32 -0800 (PST)
Message-ID: <41EE77B3.30302@cisco.com>
Date: Wed, 19 Jan 2005 10:07:31 -0500
From: Scott Miller <scomille@cisco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Newbie questions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <scomille@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: scomille@cisco.com
Precedence: bulk
X-list: linux-mips

Hi.

I'm trying to build a MIPS kernel (2.4) and I'm stuck.

I'm using the MIPS SDE-lite installed on a linux box, but I don't think 
I have it configured properly.  (I have to define things like 
-D_MIPS_SZLONG in CPPFLAGS to get it to compile.)

I've gotten it all to compile, but it fails to link at the end with 
undefined reference to handle_reserved, handle_watch, handle_adel, etc.
I assume these are intrinsics in the MIPS libraries, but I can't find them.

Is there a missing step in my configuration, or am I using the wrong tools?
-- 
"Outside of a dog, a book is a mans best friend. Inside of a dog, it's
  too dark to read." - Groucho Marx
