Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 10:15:09 +0100 (CET)
Received: from firewall.spacetec.no ([192.51.5.5]:19153 "EHLO
	pallas.spacetec.no") by linux-mips.org with ESMTP
	id <S1122165AbSKHJPI>; Fri, 8 Nov 2002 10:15:08 +0100
Received: (from tor@localhost)
	by pallas.spacetec.no (8.9.1a/8.9.1) id KAA14181;
	Fri, 8 Nov 2002 10:14:55 +0100
Message-Id: <200211080914.KAA14181@pallas.spacetec.no>
From: tor@spacetec.no (Tor Arntsen)
Date: Fri, 8 Nov 2002 10:14:53 +0100
In-Reply-To: Daniel Jacobowitz <dan@debian.org>
       "Re: SEGEV defines" (Nov  7, 23:11)
X-Mailer: Mail User's Shell (7.2.6 beta(4) 03/19/98)
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: SEGEV defines
Cc: linux-mips@linux-mips.org, george@mvista.com,
	Bradley Bozarth <bbozarth@cisco.com>
Return-Path: <tor@spacetec.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tor@spacetec.no
Precedence: bulk
X-list: linux-mips

On Nov 7, 23:11, Daniel Jacobowitz wrote:
>Presumably they match IRIX... like the rest of MIPS's oddball
>definitions.  A little hard to change them now.

FWIW: You are correct, those values come from IRIX.

>On Thu, Nov 07, 2002 at 12:33:55PM -0800, Bradley Bozarth wrote:
>> Can these be changed?
>> 
>> > Now a question, why does mips use these values:
>> >  #define SIGEV_SIGNAL   129     /* notify via signal */
>> >  #define SIGEV_CALLBACK 130     /* ??? */
>> >  #define SIGEV_THREAD   131     /* deliver via thread
>> > creation */
>> >
>> > It is the only platform that adds anything to the simple
>> > 1,2,3 values used on other platforms.  The reason I ask, is
>> > that I would like to change them to conform to all the
>> > others.
