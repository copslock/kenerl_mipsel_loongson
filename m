Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UMStRw006171
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 15:28:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UMSt5l006170
	for linux-mips-outgoing; Tue, 30 Jul 2002 15:28:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tnint11.telogy.design.ti.com ([209.116.120.7])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UMSlRw006161
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 15:28:48 -0700
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <NYM5F3DH>; Tue, 30 Jul 2002 18:28:33 -0400
Message-ID: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: GAS 4kc question...
Date: Tue, 30 Jul 2002 18:28:32 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C23818.6FEC6890"
X-Spam-Status: No, hits=0.2 required=5.0 tests=MIME_NULL_BLOCK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C23818.6FEC6890
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,

I'm trying to write some inline assembler code that needs the madd and mulu
op codes found on the 4KC processor.  I've tried setting the cpu to 4650,
but it failed to recognize the mulu instruction.  Can someone give me the
magic incantation?  I'm running right now GCC 2.95.3 from Montavista.  I
guess one way I can attack it for now is to build the op code by hand, but
that is quite dirty, IMHO...


------_=_NextPart_000_01C23818.6FEC6890
Content-Type: application/octet-stream;
	name="Nick Zajerko-McKee.vcf"
Content-Disposition: attachment;
	filename="Nick Zajerko-McKee.vcf"

BEGIN:VCARD
VERSION:2.1
N:Zajerko-McKee;Nick
FN:Nick Zajerko-McKee
TEL;WORK;VOICE:301 515 6586
EMAIL;PREF;INTERNET:nmckee@telogy.com
REV:20000810T163037Z
END:VCARD

------_=_NextPart_000_01C23818.6FEC6890--
