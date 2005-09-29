Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 08:09:06 +0100 (BST)
Received: from mail.domino-uk.com ([193.131.116.193]:6405 "EHLO
	vMIMEsweeper.dps.local") by ftp.linux-mips.org with ESMTP
	id S8133429AbVI2HIs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Sep 2005 08:08:48 +0100
Received: from dps-exchange1.dps.local (dps-exchange1) by vMIMEsweeper.dps.local
 (Clearswift SMTPRS 5.0.4) with ESMTP id <T73ad55e998c18374c1824@vMIMEsweeper.dps.local> for <linux-mips@linux-mips.org>;
 Thu, 29 Sep 2005 08:08:47 +0100
Received: from emea-exchange3.emea.dps.local ([192.168.50.10]) by dps-exchange1.dps.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 29 Sep 2005 08:08:48 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Floating point performance
Date:	Thu, 29 Sep 2005 09:08:47 +0200
Message-ID: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Floating point performance
Thread-Index: AcXDPCy3Fq71sgDySrOF/eAv33QsDwBiLs4g
From:	"Ulrich Eckhardt" <Eckhardt@satorlaser.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 29 Sep 2005 07:08:48.0183 (UTC) FILETIME=[A345EC70:01C5C4C4]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

(Sorry if this mail is garbled, I'm forced to use a sub-par client)

Matej Kupljen wrote:
> I've built soft float toolchain (with crosstool) and then build
> MPlayer with it. The performance is very low. I cannot even play the
> mp3 file with MPlayer on DBAU1200 with 400MHz CPU!
[...]
> Any other suggestions?

I'm not sure what you are doing, but if you only want to play music, I'd use Ogg Vorbis instead, which has a decoder that only uses integer arithmetic for exactly the case of FPU-less machines and the Au1200. I could also imagine an MP3 decoder written for integer only being written somewhere, but I don't know anything about it.

Uli
