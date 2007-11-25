Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 19:22:21 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:42181 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S20035114AbXKYTWJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Nov 2007 19:22:09 +0000
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 6D50F26857D;
	Sun, 25 Nov 2007 20:22:58 +0100 (CET)
X-Auth-Info: 4sAlZLa4IfZjgKGaCaU+dNC3SC+J2vxiYXMuhDZ9g+A=
X-Auth-Info: 4sAlZLa4IfZjgKGaCaU+dNC3SC+J2vxiYXMuhDZ9g+A=
Received: from mail.denx.de (p5B0DDF5F.dip.t-dialin.net [91.13.223.95])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 19F59903DA;
	Sun, 25 Nov 2007 20:22:03 +0100 (CET)
Received: from gemini.denx.de (gemini.denx.de [10.0.0.2])
	by mail.denx.de (Postfix) with ESMTP id 728086D00A7;
	Sun, 25 Nov 2007 20:22:03 +0100 (CET)
Received: from gemini.denx.de (localhost.localdomain [127.0.0.1])
	by gemini.denx.de (Postfix) with ESMTP id 4C777246B5;
	Sun, 25 Nov 2007 20:22:03 +0100 (MET)
To:	Wink Saville <wink@saville.com>
cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: Tool chain for linux using mips
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sun, 25 Nov 2007 10:43:36 PST."
             <4749C258.8020400@saville.com>
Date:	Sun, 25 Nov 2007 20:22:03 +0100
Message-Id: <20071125192203.4C777246B5@gemini.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <4749C258.8020400@saville.com> you wrote:
> 
> I was wondering which MIPS tool chains people are
> using and recommend, prebuilt and/or roll-your-own.
>  From http://www.kegel.com/crosstool/crosstool-0.43/buildlogs/
> there doesn't seem to be any combination that builds cleanly
> for the mips/mipsel.

Well, we use the ELDK, obviously.

See http://www.denx.de/wiki/view/DULG/ELDK.

For the ELDK mailing list please see
http://lists.denx.de/mailman/listinfo/eldk

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Accident: A condition in which presence of mind is good, but  absence
of body is better.
