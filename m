Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8O9HZf26231
	for linux-mips-outgoing; Mon, 24 Sep 2001 02:17:35 -0700
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8O9HVe26228
	for <linux-mips@oss.sgi.com>; Mon, 24 Sep 2001 02:17:31 -0700
Received: from r19223a ([10.105.30.54]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GK5TPH00.OBQ; Mon,
          24 Sep 2001 17:15:17 +0800 
Message-ID: <013701c144d9$af44d3c0$361e690a@huawei.com>
From: "renc stone" <renwei@huawei.com>
To: <gcc@gnu.org>
Cc: <linux-mips@oss.sgi.com>
Subject: recent gdb add-symbol-file problem?
Date: Mon, 24 Sep 2001 17:17:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi ,
 I use gdb 20010919 source form sources.redhat.com,
 target mipsel, host i386 box.

When I want to use this to debug some module of linux-mips kernel ,
trouble comes:

When I use the add-symbol-file command to add the symbols of module,

add-symbol-file mymodule.o 0xc001e060
gdb echos no problem,
but it seems to be confused:
the command
b my_func1
b my_func2
b my_func3

all show the same address, all the functions starts from ONE place?
I checked the address, it's the text section start address of this module.
Can't the gdb  correctly read the elf file of mipsel ?

 Any ideas?  Or anyone who have done this  please tell me how to get through
it .
