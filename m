Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 01:34:57 +0000 (GMT)
Received: from web30711.mail.mud.yahoo.com ([68.142.201.249]:50309 "HELO
	web30711.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134014AbVKPBej (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 01:34:39 +0000
Received: (qmail 74658 invoked by uid 60001); 16 Nov 2005 01:36:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lpQ3Rf9XP6iGvdwyQTkPSP6L8pwW1GhJ7NiF78SPMzGv+pArN8f8sScUJAM9e2XkFadBibgJcDDfTG9TQmf8LQCbdQHdcxQdlOkWLX3ac21J8FlI9TQJBtxZCAI1yzs5SViSnzot37eYXnDvA6rngLK+Tf9FwRhNX0c/PX1a7Vs=  ;
Message-ID: <20051116013634.74656.qmail@web30711.mail.mud.yahoo.com>
Received: from [203.190.168.9] by web30711.mail.mud.yahoo.com via HTTP; Wed, 16 Nov 2005 01:36:34 GMT
Date:	Wed, 16 Nov 2005 01:36:34 +0000 (GMT)
From:	Nguyen Thanh Binh <n_tbinh@yahoo.com>
Subject: Calibrating delay loop... crashes
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <n_tbinh@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n_tbinh@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello all,

When booting Monta Vista Linux on Memec board
(Virtex-4 FX12 LC), it crashed after printing the
following message:

    "Calibrating delay loop..."

By looking at the source code, I found that in the
init/main.c the problem came from the calibrate_delay
function: jiffies was not incremented (jiffies was
always equal to 0).

Have anyone get the similar problem or any experience
to fix it?

Thank you.

Binh Nguyen



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
