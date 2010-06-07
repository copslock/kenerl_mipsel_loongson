Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jun 2010 14:53:03 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:33323 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab0FGMw4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jun 2010 14:52:56 +0200
Received: by vws7 with SMTP id 7so5491124vws.36
        for <linux-mips@linux-mips.org>; Mon, 07 Jun 2010 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=wD1GWUltj1NUjG05+EaxyP39pJsraWlm3yF4E14mMu0=;
        b=QJ10cErB+HV41uUnBRR4zawQ0CcEjK6BMdG7D1Wt1dqS6Utta/lIwuCikU3sozF7om
         LrYRLom5ylrD1fSm56dfNE99omA1WoHLNTL3+6Kl6TZwubPFt1B6ZJWK8G6ZHf7iIctL
         caSAKIj8qIuW8SNy1qbsoZxZDTmmt6i5m0d84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tzITshvZ9EHa81Ngq48ECx+MOIqPVoEip5nsA4p1M41annXDuTDMVn4BvnxqJmmk8X
         o+ZBww5sDV9reHbjXBwEpX3cI8NrQub5UnHekI4/84RtS7ITraIybbgYAjhZu2lygVZC
         hjfom5KHYixbY28btE0nt07pq4kDT17su6D5I=
MIME-Version: 1.0
Received: by 10.224.53.34 with SMTP id k34mr8487125qag.290.1275915167932; Mon, 
        07 Jun 2010 05:52:47 -0700 (PDT)
Received: by 10.229.52.137 with HTTP; Mon, 7 Jun 2010 05:52:47 -0700 (PDT)
Date:   Mon, 7 Jun 2010 18:22:47 +0530
Message-ID: <AANLkTimKPVhpBzKehbm9MAzYJ4rewsQ1kSRrw8Bw8B7i@mail.gmail.com>
Subject: info needed for check_bugs
From:   naveen yadav <yad.naveen@gmail.com>
To:     linux-mips@linux-mips.org, kernelnewbies@nl.linux.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4733

Hi all ,

I am porting 2.6.30.9 to MIPS target. The target boot well, but when
it reaches to check_bugs() function.
static inline void check_bugs(void)
{
	unsigned int cpu ;
	cpu = smp_processor_id();
	cpu_data[cpu].udelay_val = loops_per_jiffy;
	check_bugs32();
#ifdef CONFIG_64BIT
	check_bugs64();
#endif
}

the debug outupt print to screen become very slow. kernel boots but it
print one char in 1 min.

When i change above function as

static inline void check_bugs(void)
{
	unsigned int cpu ;
	cpu = smp_processor_id();
	//cpu_data[cpu].udelay_val = loops_per_jiffy;
	check_bugs32();
#ifdef CONFIG_64BIT
	check_bugs64();
#endif
}

it works fine. Is there any side effect with this. ?

or how can i fix this issue.
