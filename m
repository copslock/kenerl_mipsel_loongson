Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 09:59:11 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:61269 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492291AbZFMH7F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2009 09:59:05 +0200
Received: by pzk9 with SMTP id 9so857719pzk.22
        for <multiple recipients>; Sat, 13 Jun 2009 00:58:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=+wUAP1qxsmjRHfrd1WXERFpAaPrmAf55e1r+0ahu+mc=;
        b=XON6xm3s5B9KjykT/fTbt4nRP19jaxxkbDaSdzJ6J5M6Yefrw8quxtDho8/NhQ7Ujq
         8J/1JSE+5cSP59kkk6/Wr/SBF+spr/xqJNZrtjLH5PvCJUxe2DC+0eAhysMDM89BYGfv
         4JpvJpi42bO7LkvETAl3R5z4kBuJABtz7lZTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=w3sGQUNo4pt0IvYwRSi2+DHkkyLmKP1LD9sixjxz3sfa/kerdavs/3LPRwsehGUC6K
         vmJQkCYvEueBzKWABv4Qz3PzebhS1HMhs0LP9FNqBL2M3vyarVc1N13XFxEic1QjPTin
         AKQLId9+3peZzttyLJztJRlEaEcorGlhoy6dc=
Received: by 10.114.170.1 with SMTP id s1mr7342380wae.185.1244879929450;
        Sat, 13 Jun 2009 00:58:49 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id n9sm2190029wag.26.2009.06.13.00.58.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 00:58:48 -0700 (PDT)
Subject: Error: symbol `__pastwait' is already defined
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 13 Jun 2009 15:58:42 +0800
Message-Id: <1244879922.24479.30.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, 

there is a guy reported a compiling problem in linux-2.6.29:

[...]
  CC      arch/mips/kernel/cpu-probe.o
{standard input}: Assembler messages:
{standard input}:3939: Error: symbol `__pastwait' is already defined
make[1]: *** [arch/mips/kernel/cpu-probe.o] Error 1
make: *** [arch/mips/kernel] Error 2

Seems I met this problem before, perhaps here is the reason:

arch/mips/kernel/cpu-probe.c:

void r4k_wait_irqoff(void)
{
    local_irq_disable();
    if (!need_resched())
        __asm__("   .set    push        \n"
            "   .set    mips3       \n"
            "   wait            \n"
            "   .set    pop     \n");
    local_irq_enable();
    __asm__("   .globl __pastwait   \n"
        "__pastwait:            \n");
    return;
}

there is a global symbol __pastwait defined at the end of
r4k_wait_irqoff, if r4k_wait_irqoff is called more than one time, the
__pastwait will be multi-defined. so, need to be fixed. does this fix
it?

arch/mips/kernel/cpu-probe.c:

void r4k_wait_irqoff(void)
{
    local_irq_disable();
    if (!need_resched())
        __asm__("   .set    push        \n"
            "   .set    mips3       \n"
            "   wait            \n"
            "   .set    pop     \n");
    local_irq_enable();
    return;
}
/* a dumy funciton for marking the end of r4k_wait_irqoff */
void __pastwait(void)
{
	;
}

but I am not sure the gcc compiler will tune the position of the
r4k_wait_irqoff and __pastwait or not, so seems not safe. perhaps we
should change something else instead.

perhaps we should tune the __pastwait solution directly, just spark it,
not look into it yet, seems __pastwait is only used here:

arch/mips/kernel/smtc.c:
smtc_send_ipi:

            if (cpu_wait == r4k_wait_irqoff) {
                tcrestart = read_tc_c0_tcrestart();
                if (tcrestart >= (unsigned long)r4k_wait_irqoff
                    && tcrestart < (unsigned long)__pastwait) {
                    write_tc_c0_tcrestart(__pastwait);
                    tcstatus &= ~TCSTATUS_IXMT;
                    write_tc_c0_tcstatus(tcstatus);
                    goto postdirect;
                }    
            } 

best wishes,
Wu Zhangjin 
