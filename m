Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76I6bN19586
	for linux-mips-outgoing; Mon, 6 Aug 2001 11:06:37 -0700
Received: from ex2k.pcs.psdc.com ([209.125.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76I6ZV19582
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 11:06:36 -0700
content-class: urn:content-classes:message
Subject: set_bit() function.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 6 Aug 2001 11:04:38 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A21EB@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: set_bit() function.
Thread-Index: AcEeokFaRAkLCp4hQ8eLxQFGPnYOJw==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f76I6aV19583
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, ALL:

I have a question regarding the function set_bit() in
linux/include/asm-mips/bitops.h for MIPS 1(R3000).

extern __inline__ void set_bit(int nr, void * addr)
{
	int	mask;
	int	*a = addr;
	__bi_flags;

	a += nr >> 5;                        // <---- why shits right 5
bits? 
	mask = 1 << (nr & 0x1f);
	__bi_save_flags(flags);
	__bi_cli();
	*a |= mask;
	__bi_restore_flags(flags);
}

In

extern __inline__ int test_bit(int nr, const void *addr)
{
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr
>> 5])) != 0;
}

addr is always passed in as a pointer to an integer. Why does it use
array [nr >>5]?

Any help is greatly appreciated.

Thanks.

Steven Liu
