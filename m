Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9DL2gI19574
	for linux-mips-outgoing; Sat, 13 Oct 2001 14:02:42 -0700
Received: from serio.al.rim.or.jp (serio.al.rim.or.jp [202.247.191.123])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9DL2bD19570
	for <linux-mips@oss.sgi.com>; Sat, 13 Oct 2001 14:02:38 -0700
Received: from mail2.rim.or.jp
	by serio.al.rim.or.jp (3.7W/HMX-13) id GAA09639
	for <linux-mips@oss.sgi.com>; Sun, 14 Oct 2001 06:02:36 +0900 (JST)
Received: from speedwin (speed.galaxies.jp [211.8.151.62]) by mail2.rim.or.jp (8.9.3/3.7W)
	id GAA14605 for <linux-mips@oss.sgi.com>; Sun, 14 Oct 2001 06:02:35 +0900 (JST)
From: "Yoshi-K" <ykida@yk.rim.or.jp>
To: <linux-mips@oss.sgi.com>
Subject: MySQL
Date: Sun, 14 Oct 2001 06:02:35 +0900
Message-ID: <MBECLJKHNDHFIBCEPBGLEECJDHAA.ykida@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011012225433.A10523@lucon.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2505.0000
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello.
As for everybody, does MySQL operate without trouble?

OS: PS2 Linux.
CPU: R5900
gcc 2.95.2 
glibc 2.2.2
$ uname -a 
Linux speed-ps 2.2.1 #94 Thu Apr 19 12:13:01 JST 2001 mips unknown 


# cd mysql-3.23.42
# ./configure --with-charset=ujis --with-mysqld-user=mysql
# make;make install
# chown -R mysql.mysql /usr/local/var

# /usr/local/bin/mysql_install_db --user=mysql
Preparing db table
Preparing host table
Preparing user table
Preparing func table
Preparing tables_priv table
Preparing columns_priv table
Installing all prepared tables
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
ERROR: 1033 Incorrect information in file: './mysql/db.frm'
011006 21:20:23 /usr/local/libexec/mysqld: Shutdown Complete

-------------------------
Yoshikatsu Kida
E-Mail: yoshi@galaxies.jp
http://galaxies.jp/
