Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 03:22:20 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:17752 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20023805AbXILCWM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 03:22:12 +0100
Received: by ug-out-1314.google.com with SMTP id u2so197116uge
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2007 19:21:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=TY6N3LBhZjAZSUenpH7e5RSZ6uCngnFfIBKW/ZyRX18=;
        b=R6KVThlN3x1ziBdLUl0YuyfjFm0fQXM7xfG0pzBrNQvghpUzCILqeODH8r8vsJRFtgqnNWITxWtq09cF4y/XWFpcQCG0xy1TVsFtVvqWuoo5lB4IUc7glEqfWW8pGg1cVteWtuvlgHtEmpx6mZrZHNjBDiaU7gVmqqVWhiOJkSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=Lnf/T7jUYIGYp8dSjFqnvOE/spt3Pu4eSWrbXEyF743W1B2mUWdTRhbH8HoX/ug/dzZTcAzNBH5HXNdFIa8Y8PpEY4UeqLtcwkaEzkijmC3krhtesF90RfW8Q3CTk+Y+g/dS9ZW/z4CUaqcNb/j9mQxtyseYgbW7jhsKMCkpypc=
Received: by 10.78.170.17 with SMTP id s17mr845964hue.1189563713606;
        Tue, 11 Sep 2007 19:21:53 -0700 (PDT)
Received: by 10.78.15.6 with HTTP; Tue, 11 Sep 2007 19:21:53 -0700 (PDT)
Message-ID: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
Date:	Wed, 12 Sep 2007 10:21:53 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: does the SAVE_ALL nesting in kernel?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16035_2822037.1189563713599"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_16035_2822037.1189563713599
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all
            i have a mips board,  and the SDRAM speed(bus clock) is not too
fast.
             so i want change  the SAVE_ALL and RESTORE_ALL to use
internal-ram(high speed).
            i just wonder whether the SAVE_ALL netsting in kernel  for mips
arch?
            if not, i think  maybe 1k byte for SAVE_ALL is enough( 32regs
X4, and some cp0_regs).
            but if  the SAVE_ALL nesting, maybe i need to keep a stack in
internal-ram.
            thanks for any hints．

Best Regards

--
zzh

------=_Part_16035_2822037.1189563713599
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i
have a mips board,&nbsp; and the SDRAM speed(bus clock) is not too fast.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; so i want change&nbsp;
the SAVE_ALL and RESTORE_ALL to use internal-ram(high speed).<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i
just wonder whether the SAVE_ALL netsting in kernel&nbsp; for mips arch?<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if not, i think&nbsp; maybe
1k byte for SAVE_ALL is enough( 32regs X4, and some cp0_regs).<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; but if&nbsp; the SAVE_ALL nesting, maybe i need to keep a stack in internal-ram.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thanks for any hints．<br>
<br>
Best Regards<br>
<br>
--<br>
zzh<br>
<br>

------=_Part_16035_2822037.1189563713599--
