Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Mar 2009 09:23:44 +0000 (GMT)
Received: from mail-ew0-f180.google.com ([209.85.219.180]:38652 "EHLO
	mail-ew0-f180.google.com") by ftp.linux-mips.org with ESMTP
	id S20808875AbZCOJXg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Mar 2009 09:23:36 +0000
Received: by ewy28 with SMTP id 28so3396415ewy.0
        for <linux-mips@linux-mips.org>; Sun, 15 Mar 2009 02:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.39.85 with SMTP id c63mr1385897web.103.1237109010733; Sun, 
	15 Mar 2009 02:23:30 -0700 (PDT)
Date:	Sun, 15 Mar 2009 11:23:30 +0200
Message-ID: <26d57bbb0903150223u7e0cc8bcl28e011f8fea9aa6c@mail.gmail.com>
Subject: Printing register value inside kernel panic
From:	Ori Idan <ori@helicontech.co.il>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016365ee476221c35046524e301
Return-Path: <ori@helicontech.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ori@helicontech.co.il
Precedence: bulk
X-list: linux-mips

--0016365ee476221c35046524e301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I would like to print register values using the function show_registers
(defined in traps.c), this function needs a struct pt_regs as a parameter
and I have no idea how to fill values inside this struct

-- 
Ori Idan

--0016365ee476221c35046524e301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<div dir="ltr">I would like to print register values using the function show_registers (defined in traps.c), this function needs a struct pt_regs as a parameter and I have no idea how to fill values inside this struct<br><br>
-- <br>Ori Idan<br><br></div>

--0016365ee476221c35046524e301--
