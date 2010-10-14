Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 02:06:55 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:35288 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491191Ab0JNAGv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 02:06:51 +0200
Received: by qyk35 with SMTP id 35so1159940qyk.15
        for <linux-mips@linux-mips.org>; Wed, 13 Oct 2010 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=6Zz+f5ynx73C//ZSEV23PaGvj4+pUntdq3w/SEsn7uA=;
        b=ma8VAJhzkxwcUGsm7a+AgYFi6NWi+v5GEu+S6IUHHic5rCApSXLiEY0qS6zUEg5gdX
         YO0/Hc7DXoTrQGjrUMDQoVOerVfr+UcHYVbERA5F045ukUUNnMrudbng1CV0dKCaPBqn
         VZubZR5ZhoMTlzWzpPzxXtiRDxNqN+RvzuZBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=ixKXlAfReswIJI9qvKGLEgAhsDxMymcPomaS5F+KmMcwngkrorObPvf7HHLyZvOmGf
         G+vT4sMd/+hj/nHymuyVHP21KDDcv+Vpyb5YmoK4mAuMSwatqduUcpmJAeDZ4HXxjaBv
         tZQeBNllIi6a5ekeaOXE8+Plu/C5WSQm+k3Ak=
MIME-Version: 1.0
Received: by 10.224.10.204 with SMTP id q12mr1471185qaq.171.1287014802715;
 Wed, 13 Oct 2010 17:06:42 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Wed, 13 Oct 2010 17:06:42 -0700 (PDT)
Date:   Thu, 14 Oct 2010 08:06:42 +0800
Message-ID: <AANLkTinJXcpd7rVj4QFY0CpskSiZuJB4y10sbG1Td5n9@mail.gmail.com>
Subject: va_list implementation on mips64 , with 32bit cross compiled
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     chelly wilbur <wilbur512@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

I am planning  to use va_list on a single module, however the
following code did not work properly.

typedef char *	va_list;
#define _INTSIZEOF(n)	( (sizeof(n) + sizeof(int) - 1) & ~(sizeof(int) - 1) )
#define va_start(ap,v)	( ap = (va_list)&v + _INTSIZEOF(v) )
#define va_arg(ap,t)	( *(t *)((ap += _INTSIZEOF(t)) - _INTSIZEOF(t)) )
#define va_end(ap)	( ap = (va_list)0 )

void test_val_list()
{
unsigned long test=0x1234;
test_printk("test:0x%x OK\n",aaa);
}

void test_printk(const char *format, ...)
{
va_list args;
va_start(args, format);
unsigned int v1 = va_arg(args,unsigned long);
printk("v1 is 0x%x\n",v1);
unsigned int v2 = va_arg(args,unsigned long);
printk("v2 is 0x%x\n",v2);
}


The result is :

v1 is 0x00000013

v2 is 0x00000019

Why this happened ? shouldn't v1 be 0x1234 here?

Thank you
