Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2004 07:56:36 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.189]:52428
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225247AbUGIG4b>; Fri, 9 Jul 2004 07:56:31 +0100
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1BipJ7-0005dy-00; Fri, 09 Jul 2004 08:56:29 +0200
Received: from [84.128.29.15] (helo=pegasus.thalreit)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1BipJ5-00023r-00; Fri, 09 Jul 2004 08:56:27 +0200
Received: from thalreit.dyndns.org (localhost.thalreit [127.0.0.1])
	by pegasus.thalreit (8.12.6/8.12.6) with SMTP id i696uGDk092590;
	Fri, 9 Jul 2004 08:56:20 +0200 (CEST)
	(envelope-from Volker.Jahns@thalreit.de)
Received: from 194.59.120.11
        (SquirrelMail authenticated user volker)
        by thalreit.dyndns.org with HTTP;
        Fri, 9 Jul 2004 08:56:26 +0200 (CEST)
Message-ID: <59553.194.59.120.11.1089356186.squirrel@thalreit.dyndns.org>
In-Reply-To: <20040708194821.GA6925@deprecation.cyrius.com>
References: <33009.194.59.120.11.1089291164.squirrel@thalreit.dyndns.org>
    <40ED9097.6040800@kanux.com> <20040708192625.GB9312@ikarus.thalreit>
    <20040708194821.GA6925@deprecation.cyrius.com>
Date: Fri, 9 Jul 2004 08:56:26 +0200 (CEST)
Subject: Re: sharp mobilon hc-4100
From: "Volker Jahns" <Volker.Jahns@thalreit.de>
To: "Martin Michlmayr" <tbm@cyrius.com>
Cc: linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3
Importance: Normal
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5b79f71352ef1364d4beaa70fe75636d
Return-Path: <Volker.Jahns@thalreit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Volker.Jahns@thalreit.de
Precedence: bulk
X-list: linux-mips

> * Volker Jahns <volker@thalreit.de> [2004-07-08 21:26]:
>> On the other hand the mobilon needs
>> #               define FB_X_RES         640
>> #               define FB_X_RES         240
that is correct.
>
> I thought it was 800x480.  BTW, how do you boot this thing?  From
> WinCE or can you override the ROM?
pbsdboot :-( But if you have an idea on how to write the ROM, please let
me know.

-- 
Volker Jahns, volker@thalreit.de, http://thalreit.de, DG7PM
