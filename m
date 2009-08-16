Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Aug 2009 16:21:51 +0200 (CEST)
Received: from mail-yx0-f183.google.com ([209.85.210.183]:58776 "EHLO
	mail-yx0-f183.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492601AbZHPOVn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Aug 2009 16:21:43 +0200
Received: by yxe13 with SMTP id 13so3323328yxe.22
        for <linux-mips@linux-mips.org>; Sun, 16 Aug 2009 07:21:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=2naHafWRdP5iKAYt/BGC7nGv54Cn2yJIAcxxHqBiWtQ=;
        b=PFMMz/BhdMidGtpO3zAHUoLEz75AppTnnzvfMpDxsgio2+DJVIpB+kFz+bMynGoBDs
         DWUb6s0SjfhjAqxvA2zMzkpwGueWOBWwOfZAIXc+9aEJYlvpiI22frnN5Rw6kiSRa9E9
         vPAsD4zzoyDiImhi5eT2W5wG+YFPmuc8ABTrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hxMwgW2Emz4sO+S2w9UnO16VT0ssz8Hbt6E8Y0ovlAiqTSXeEw2GJdpz4NwXI0F1IH
         HFMqqJhBJL4LrnHCXrAmiZCKKeOij4i2yBEWkX/hHuyJYnkCU2B/jep4+ideFqqSVyR8
         VSNZwz16cGh2ImtuyDK4rRTIfLP7rpEcGnQvc=
MIME-Version: 1.0
Received: by 10.100.33.15 with SMTP id g15mr2710028ang.188.1250432497326; Sun, 
	16 Aug 2009 07:21:37 -0700 (PDT)
In-Reply-To: <9651e57b0908160650s2b81e48bod8fc1d50c19c8e5b@mail.gmail.com>
References: <9651e57b0908160650s2b81e48bod8fc1d50c19c8e5b@mail.gmail.com>
Date:	Sun, 16 Aug 2009 19:51:36 +0530
Message-ID: <9651e57b0908160721g4d9893bfrcd1afcb66f3b28d1@mail.gmail.com>
Subject: Fwd: mips 16 bit compilation lead to crash
From:	keshav yadav <keshav.yadav2005@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <keshav.yadav2005@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keshav.yadav2005@gmail.com
Precedence: bulk
X-list: linux-mips

---------- Forwarded message ----------
From: keshav yadav <keshav.yadav2005@gmail.com>
Date: Sun, Aug 16, 2009 at 7:20 PM
Subject: mips 16 bit compilation lead to crash
To: gcc-help@gcc.gnu.org, gcc-help@gnu.org


Hi all,

I want to use MIPS 16 bit instruction similar to ARM thumb mode. But i
am getting error

#mips-gcc   -mips16   -o test.o test.c

/tmp/ccJFGlL0.s: Assembler messages:
/tmp/ccJFGlL0.s:17: Internal error!
Assertion failure in macro_build_lui at ../../gas/config/tc-mips.c line 3142

1. Is there problem in toolchain i have made ?
2. is i am giving 16 bit option to gcc correctly.

Regards
Keshava
