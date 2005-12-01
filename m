Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2005 15:04:12 +0000 (GMT)
Received: from [62.154.208.154] ([62.154.208.154]:63899 "EHLO
	firewall1.addi-data.de") by ftp.linux-mips.org with ESMTP
	id S8134039AbVLAPDp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Dec 2005 15:03:45 +0000
Received: from [172.16.2.26] (helo=security01.addi-data.intra)
	by firewall1.addi-data.de with esmtp (Exim 4.43)
	id 1Ehq1a-0006oU-9I
	for linux-mips@linux-mips.org; Thu, 01 Dec 2005 16:07:07 +0100
Received: from security1.addi-data.de (exchange01.addi-data.intra) by 
    security01.addi-data.intra (Clearswift SMTPRS 5.0.9) with ESMTP id 
    <T74f37c7607ac10021ac30@security01.addi-data.intra> for 
    <linux-mips@linux-mips.org>; Thu, 1 Dec 2005 16:07:06 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: get an usleep() with less than 20ms on 2.4.27
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Thu, 1 Dec 2005 16:07:05 +0100
Message-ID: <DD0BA80209AFF04091B518EA708D0A0B2F67DF@exchange01.addi-data.intra>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: get an usleep() with less than 20ms on 2.4.27
Thread-Index: AcX2epQlVpuToN9OS3CENEPXxjXM+QADR/4g
From:	"Conil.Christophe" <Conil.Christophe@addi-data.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <conil.christophe@addi-data.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Conil.Christophe@addi-data.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm using a 2.4.27 Kernel on MIPS.

I'm actually programming a USR-Space software which needs high-precision sleep() functions. Actually, by using them, I can't get a sleep time lower than 20 ms. (even with a usleep(1) which should sleep for 1 microsecond) I thought it may came from the Linux default scheduler, so I increased its resolution by modifying HZ and CLOCKS_PER_SEC (I set them to 1000 instead of 100) in the /linux/include/asm-mips/param.h file. I'm now having a minimum usleep time of 2ms, which is better, but still not perfect (since I need at least 1ms) If I continue increasing these 2 values, my kernel doesn't compile because of /linux/include/linux/timex.h. 

Do you have a clue what could I do to have a non-active (without a while) sleeping time fewer than 2ms? (A sleeping time of 0.5 ms would be perfect)

Please excuse my newbieness if I said something not relevant... 

Thank you very much,

Christophe CONIL


Content of /linux/include/linux/timex.h
--------------------------------------------------------------------------------
#if HZ >= 12 && HZ < 24
# define SHIFT_HZ 4
[...]
#elif HZ >= 768 && HZ < 1536
# define SHIFT_HZ 10
#else
# error You lose. <
#endif
--------------------------------------------------------------------------------


Content of /linux/include/asm-mips/param.h
--------------------------------------------------------------------------------
#ifndef _ASM_PARAM_H
#define _ASM_PARAM_H

#ifndef HZ

#ifdef __KERNEL__

/* Safeguard against user stupidity  */
#ifdef _SYS_PARAM_H
#error Do not include <asm/param.h> with __KERNEL__ defined!
#endif

#include <linux/config.h>

/* This is the internal value of HZ, that is the rate at which the jiffies
   counter is increasing.  This value is independent from the external value
   and can be changed in order to suit the hardware and application
   requirements.  */
#  define HZ 1000 /* CC : Previous value was 100 */
#  define hz_to_std(a) (a)

#else /* defined(__KERNEL__)  */

/* This is the external value of HZ as seen by user programs.  Don't change
   unless you know what you're doing - changing breaks binary compatibility.  */
#define HZ 100 

#endif /* defined(__KERNEL__)  */
#endif /* defined(HZ)  */

[...]

#ifdef __KERNEL__
# define CLOCKS_PER_SEC     1000     /* frequency at which times() counts */ /* CC : Previous value was 100 */
#endif

#endif /* _ASM_PARAM_H */
--------------------------------------------------------------------------------

**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote confirms that this email message has been scanned for 
the presence of computer viruses.
**********************************************************************
