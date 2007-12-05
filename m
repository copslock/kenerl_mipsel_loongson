Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 18:20:31 +0000 (GMT)
Received: from bay0-omc3-s37.bay0.hotmail.com ([65.54.246.237]:18670 "EHLO
	bay0-omc3-s37.bay0.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20030698AbXLESUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2007 18:20:21 +0000
Received: from BAY125-W45 ([65.55.130.80]) by bay0-omc3-s37.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Dec 2007 10:20:14 -0800
Message-ID: <BAY125-W4502FE9A8C50C8A890C0608A6E0@phx.gbl>
X-Originating-IP: [157.185.36.161]
From:	Nathan Eggan <nathan_eggan@live.com>
To:	<linux-mips@linux-mips.org>
Subject: Bug in Au1x00 UART or USB drivers for 2.6 kernels?
Date:	Wed, 5 Dec 2007 18:20:14 +0000
Importance: Normal
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 05 Dec 2007 18:20:14.0229 (UTC) FILETIME=[7ADB7450:01C8376B]
Return-Path: <nathan_eggan@live.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan_eggan@live.com
Precedence: bulk
X-list: linux-mips


All,

After some thorough testing and exploration, I believe I have uncovered a bug in the Au1x00 driver code of either the UART or the USB host in the Linux 2.6 kernels.  In short, this bug causes corruption of the data being returned from the UART whenever both it and the USB are in use.

The issue I’m seeing is pretty simple to describe.  When I have a data stream running over a UART, and I introduce traffic on the USB, the data returning from my UART is corrupted.  (I will describe what the corruption looks like shortly.)  Even simple events such as hotplugging a device can and will create the corruption in the UART’s serial stream.  As expected, the amount of corruption seems dependent upon the amount of traffic on the USB.
 
I discovered this issue while working with a DBAu1500 running a buildroot package that contains a Linux 2.6.21 kernel (patched for the MIPS from the linux-mips.org site) and Busybox 1.7.3.  To keep YAMON from bombing during builds, I’m still using a trusty gcc 3.4.5 compiler to build it all.

To determine if the issue was particular to just that board or that kernel source, I ran the same tests on two other DBAu1500s I have lying around here.  I tested two 2.6 kernels (a 2.6.17 and the 2.6.21) and one 2.4 kernel I used several years ago.  Both 2.6 kernels displayed the same issue.  The 2.4.26 kernel, on the other hand, worked flawlessly.  This does not really surprise me, as I’m presently tempted to believe that the issue somehow has to do with the interplay between the USB and the Au1x00 UART support that is now integrated into the standard 8250 driver.

To really monitor the byte sequences returning, I wrote a simple, multi-threaded test app designed to test the loopback of the UART.  It works by generating a 4k packet containing a repeating alphabet sequence [ABCDEF…XYZAB…], sending it over the UART, and then reading it back again.  (The loopback is achieved by tying the TX and RX leads of the UART together.)  On the receive side, the receive buffer is initialized with (0x20) characters, so I know whether bytes were skipped or misread.  Once an entire 4k packet has been sent and received, the TX and RX threads exit and the main application compares their results byte-for-byte.  Any discrepancies are reported, and then the process repeats.

(To aid in testing, I’ve included the code from this test app, as well as instructions for its use, at the conclusion of this email.)

Now, the corruption I’m seeing looks like this:  (All of this data was taken by running my test code on ttyS1(tts/1) and simply plugging and unplugging a USB 802.11 wireless device and connecting it to a WAP.)

<<<<<<<<<<< start: code output>>>>>>>>>>>>>
Iteration: 197...done, cross-checking...done, MATCHED!
- RX ERROR: '' found in read return.  Byte 81 of the 113 bytes read does not fit between 'A' & 'Z'!
done, cross-checking...

Index:  TX:     RX:
3568    'G'[47] ''[00]
3569    'H'[48] 'G'[47]
3570    'I'[49] 'H'[48]
3571    'J'[4a] 'I'[49]
3572    'K'[4b] 'J'[4a]
3573    'L'[4c] 'K'[4b]
3574    'M'[4d] 'L'[4c]
3575    'N'[4e] 'M'[4d]
3576    'O'[4f] 'N'[4e]
3577    'P'[50] 'O'[4f]
3578    'Q'[51] 'P'[50]
3579    'R'[52] 'Q'[51]
3580    'S'[53] 'R'[52]
3581    'T'[54] 'S'[53]
3582    'U'[55] 'T'[54]
3583    'V'[56] 'U'[55]

        *** 16 Errors detected @ iteration 197! ***
Iteration: 200...done, cross-checking...done, MATCHED!
- RX ERROR: '' found in read return.  Byte 57 of the 105 bytes read does not fit between 'A' & 'Z'!
done, cross-checking...

Index:  TX:     RX:
2176    'S'[53] ''[00]
2177    'T'[54] 'S'[53]
2178    'U'[55] 'T'[54]
2179    'V'[56] 'U'[55]
2180    'W'[57] 'V'[56]
2181    'X'[58] 'W'[57]
2182    'Y'[59] 'X'[58]
2183    'Z'[5a] 'Y'[59]
2184    'A'[41] 'Z'[5a]
2185    'B'[42] 'A'[41]
2186    'C'[43] 'B'[42]
2187    'D'[44] 'C'[43]
2188    'E'[45] 'D'[44]
2189    'F'[46] 'E'[45]
2190    'G'[47] 'F'[46]
2191    'H'[48] 'G'[47]

        *** 16 Errors detected @ iteration 200! ***
Iteration: 203...done, cross-checking...done, MATCHED!
- RX ERROR: '' found in read return.  Byte 81 of the 129 bytes read does not fit between 'A' & 'Z'!

- RX ERROR: '' found in read return.  Byte 113 of the 129 bytes read does not fit between 'A' & 'Z'!
done, cross-checking...

Index:  TX:     RX:
0832    'A'[41] ''[00]
0833    'B'[42] 'A'[41]
0834    'C'[43] 'B'[42]
0835    'D'[44] 'C'[43]
0836    'E'[45] 'D'[44]
0837    'F'[46] 'E'[45]
0838    'G'[47] 'F'[46]
0839    'H'[48] 'G'[47]
0840    'I'[49] 'H'[48]
0841    'J'[4a] 'I'[49]
0842    'K'[4b] 'J'[4a]
0843    'L'[4c] 'K'[4b]
0844    'M'[4d] 'L'[4c]
0845    'N'[4e] 'M'[4d]
0846    'O'[4f] 'N'[4e]
0847    'P'[50] 'O'[4f]
0864    'G'[47] ''[00]
0865    'H'[48] 'G'[47]
0866    'I'[49] 'H'[48]
0867    'J'[4a] 'I'[49]
0868    'K'[4b] 'J'[4a]
0869    'L'[4c] 'K'[4b]
0870    'M'[4d] 'L'[4c]
0871    'N'[4e] 'M'[4d]
0872    'O'[4f] 'N'[4e]
0873    'P'[50] 'O'[4f]
0874    'Q'[51] 'P'[50]
0875    'R'[52] 'Q'[51]
0876    'S'[53] 'R'[52]
0877    'T'[54] 'S'[53]
0878    'U'[55] 'T'[54]
0879    'V'[56] 'U'[55]

        *** 32 Errors detected @ iteration 203! ***
Iteration: 204...
<<<<<<<<<<< end: code output>>>>>>>>>>>>>

As you can see, when the error occurs it effects an entire 16-byte block, and only that 16-byte block.  If you look at the byte index numbers above, you will notice that the stream always resyncs after taking a hit.  So, the error is not just a dropped or inserted byte.  If either of those events occurred, I would expect the entire subsequent serial stream to be off by the number of characters dropped or added.  That does not seem to be happening here.

Moreover, as you can see, there is a definite pattern to the corruption within the block.  It is not random.  In a corrupted block, the first byte is cleared to “0” (a value my test code is not permitted to use.)  All subsequent bytes are then shifted 1 location to the right with the last byte being lost.

This is where my current work has brought me.  I am beginning to dive into the kernel source to see if I can track down the issue, but before doing so I figured I would pass this around to the gurus here to see what you thought.  By providing a solid description of the issue, as well as instructions for easily reproducing it, I’m hopeful that a resolution to it can be found soon.

Thanks for your help!
Nathan Eggan



PS - Here is the test code I’ve been using.  Please review it, and feel free to comment on it.  To compile it, I’ve been issuing “mipsel-linux-g++  -static –lpthread”.  (I ran -static against it to make it library independent when I was switching between 2.4 and 2.6 kernels.)

Test Code:
<<<<<<<<<<< start: test code>>>>>>>>>>>>>
// standard includes
#include 
#include 
#include 
#include 
#include 
#include 
#include 
#include 
#include 
#include 
#include 
#include 

// custom includes


/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

enum PARITY_TYPE
{
	NO_PARITY,
	PARITY
};


/******************************************************************************
 *
 * Name: OpenSerialPort
 *
 * Purpose: This function opens a standard serial port
 *
 *****************************************************************************/
int OpenSerialPort (
    char *dev_name,
    int baud_rate,
    int num_bytes,
    PARITY_TYPE parity
    )
{
    struct termios options;
    int ret_val = 0, fd = -1;

    // open the proper port
	char full_dev_name[256];
	ret_val = sprintf(full_dev_name, "/dev/%s", dev_name);
	if ( (ret_val <= 0) || (full_dev_name == NULL) )
	{
		printf("OpenSerialPort(): Failed to open serial port: '%s': errno = '%s'\n", full_dev_name, strerror(errno));
		// will return fd = -1
	}
	else
	{
		fd = open(full_dev_name, O_RDWR | O_NOCTTY| O_NDELAY);

		// error checking
		if (fd < 0)
		{
			printf ("OpenSerialPort(): Failed to open serial port: '%s': errno = '%s'\n", full_dev_name, strerror(errno));
		}
		else // success, now configure the port
		{
			// set the port to block on read
			fcntl(fd, F_SETFL, 0);

			// get the port's current attribute set
			tcgetattr(fd, &options);
			// set up the baud rate - lock at 115200 for now
			int desired_baud_rate = 0;
			switch (baud_rate)
			{
				// put the most likely first
				case 57600:
						desired_baud_rate = B57600;
						break;

				case 115200:
						desired_baud_rate = B115200;
						break;

				case 230400:
						desired_baud_rate = B230400;
						break;

#if !defined(HOST)
				case 460800:
						desired_baud_rate = B460800;
						break;

				case 500000:
						desired_baud_rate = B500000;
						break;

				case 576000:
						desired_baud_rate = B576000;
						break;

				case 921600:
						desired_baud_rate = B921600;
						break;

				case 1000000:
						desired_baud_rate = B1000000;
						break;

				case 1152000:
						desired_baud_rate = B1152000;
						break;

				case 1500000:
						desired_baud_rate = B1500000;
						break;

				case 2000000:
						desired_baud_rate = B2000000;
						break;

				case 2500000:
						desired_baud_rate = B2500000;
						break;

				case 3000000:
						desired_baud_rate = B3000000;
						break;

				case 3500000:
						desired_baud_rate = B3500000;
						break;

				case 4000000:
						desired_baud_rate = B4000000;
						break;
#endif

				case 50:
						desired_baud_rate = B50;
						break;

				case 75:
						desired_baud_rate = B75;
						break;

				case 110:
						desired_baud_rate = B110;
						break;

				case 134:
						desired_baud_rate = B134;
						break;

				case 150:
						desired_baud_rate = B150;
						break;

				case 200:
						desired_baud_rate = B200;
						break;

				case 300:
						desired_baud_rate = B300;
						break;

				case 600:
						desired_baud_rate = B600;
						break;

				case 1200:
						desired_baud_rate = B1200;
						break;

				case 1800:
						desired_baud_rate = B1800;
						break;

				case 2400:
						desired_baud_rate = B2400;
						break;

				case 4800:
						desired_baud_rate = B4800;
						break;

				case 9600:
						desired_baud_rate = B9600;
						break;

				case 19200:
						desired_baud_rate = B19200;
						break;

				case 38400:
						desired_baud_rate = B38400;
						break;

			}

			if (desired_baud_rate)
			{
				cfsetispeed(&options, desired_baud_rate);
				cfsetospeed(&options, desired_baud_rate);
			}
			else
			{
				/* set baud to something that is defined */
				cfsetispeed(&options, B115200);
				cfsetospeed(&options, B115200);
			}

			// enable the receiver and set local mode
			options.c_cflag |= (CLOCAL | CREAD); // NEVER set this directly, use "|="
			// set the 8N1
			options.c_cflag &= ~(PARENB); // disable parity checking [N]
			options.c_cflag &= ~(CSTOPB); // disable 2 stop bits (means 1 stop bit) [1]
			options.c_cflag &= ~(CSIZE);  // mask the character bits
			options.c_cflag |= num_bytes;     // select 8 data bits [8]

			// output options -- post process output and map new lines to
			// carriage return-new lines
			options.c_oflag |= OPOST | ONLCR;

			// lock in the options
			tcsetattr(fd, TCSANOW, &options);


		}
	}

    return(fd);
}

/******************************************************************************
 *
 * Name: OpenRawSerialPort
 *
 * Purpose: This function opens a raw serial port
 *
 *****************************************************************************/
int OpenRawSerialPort (
    char *dev_name,
    int baud_rate,
    int num_bytes,
    PARITY_TYPE parity,
	unsigned char vmin,
	unsigned char vtime
    )
{

#define ALT_SERIAL_SETUP	(1)

    int fd = OpenSerialPort (dev_name, baud_rate, num_bytes, parity);

    if (fd>= 0)
    {
        struct termios options;

        // get the port's current attribute set
        tcgetattr(fd, &options);

#if ALT_SERIAL_SETUP
		options.c_lflag = 0;
		// ignore framing and parity errors
		options.c_iflag = IGNPAR;
        // disable output post-processing
		options.c_oflag = 0;
#else
        
		// disable H/W flow control
        options.c_cflag &= ~(CRTSCTS);
        // use RAW input - i.e. do NOT process the stream, simply pump the bytes in/out
        options.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);
        // disable input parity check
        options.c_iflag &= ~(INPCK);
        // disable S/W flow control
        options.c_iflag &= ~(IXON | IXOFF | IXANY);
        // disable a bunch of stuff
        options.c_iflag &= ~(IGNBRK | BRKINT | INLCR | IGNCR | ICRNL | IUCLC | IMAXBEL);
        // disable output post-processing
        options.c_oflag &= ~(OPOST);
#endif
        // set the return rules for read()
        options.c_cc[VMIN] = vmin; // defaults to MAX_INPUT; at least MAX_INPUT bytes must be read;
        options.c_cc[VTIME] = vtime; // defaults to 1 => inter-byte delay = 1/10 sec

		// flush read or written data
		tcflush(fd, TCIFLUSH);
        // lock in the options
        tcsetattr(fd, TCSANOW, &options);
    }

    return (fd);
}


/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

//#define DEBUG


#define STRING_SIZE (4096)
#define MAX_TIMEOUTS (10)

#ifdef DEBUG
#define DEBUG_PRINT		(printf)
#else
#define DEBUG_PRINT(...)
#endif

// globals
int fd;
pthread_t tx_thread, rx_thread;
unsigned char *send_string = NULL;
unsigned char *recv_string = NULL;

/******************************************************************************
 *
 * Name:	catchControlC
 *
 * Purpose:	Catches the control-c and triggers a shutdown event so the
 *			application shuts down gracefully.
 *
 *****************************************************************************/
void catchControlC(int)
{
	printf("\n- killing tx_thread...\n");fflush(stdout);
	pthread_kill(tx_thread, 0);
	printf("\n- killing rx_thread...\n");fflush(stdout);
	pthread_kill(rx_thread, 0);
	printf("\n- closing fd...\n");fflush(stdout);
	close(fd);

	if (send_string)
	{
		delete (send_string);
	}
	if (recv_string)
	{
		delete (recv_string);
	}

	exit(1);
}


void *tx(void *params)
{
	DEBUG_PRINT("TX thread\n");

	// unsigned char *send_string = (char *)params;
	if (send_string == NULL)
	{
		printf("ERROR: send_string = NULL\n");
		pthread_exit(NULL);
	}

	// scan for non-alphabet characters in received string
	for (int x=0; x < STRING_SIZE; x++)
	{
		if ( (send_string[x] < 'A') || (send_string[x]> 'Z') )
		{
			printf("\n- TX ERROR: '%c' found in read return!\n", send_string[x]);
		}
	}

	int num_bytes_written = 0, num_timeouts = 0;
	while ( (num_bytes_written < STRING_SIZE) && (num_timeouts < MAX_TIMEOUTS) )
	{
		int z = write(fd, &send_string[num_bytes_written], (STRING_SIZE - num_bytes_written));
		if (z == 0) // timed out
		{
			num_timeouts++;
			printf("- TX: %d of %d sent, timeouts: %d\n", num_bytes_written, STRING_SIZE, num_timeouts);fflush(stdout);
		}
		else if ( num_bytes_written < 0 )
		{
			printf("*** ERROR: Failed to send!\n");fflush(stdout);
			pthread_exit(NULL);
		}
		num_bytes_written += z;
		DEBUG_PRINT("- TX: %d of %d sent, timeouts: %d\n", num_bytes_written, STRING_SIZE, num_timeouts);fflush(stdout);
	}
	
	if (num_timeouts> MAX_TIMEOUTS)
	{
		printf("-- TX: Exceeded timeout allotment (%d)\n", MAX_TIMEOUTS);
	}

	pthread_exit(NULL);
}


void *rx(void *params)
{
	DEBUG_PRINT("RX thread\n");

	// unsigned char *recv_string = (char *)params;
	if (recv_string == NULL)
	{
		printf("ERROR: recv_string = NULL\n");
		pthread_exit(NULL);
	}

	int num_bytes_read = 0, num_timeouts = 0;
	while ( (num_bytes_read < STRING_SIZE) && (num_timeouts < MAX_TIMEOUTS) )
	{
		int y = read(fd, &recv_string[num_bytes_read], (STRING_SIZE - num_bytes_read));
		if (y == 0) // timed out
		{
			num_timeouts++;
			printf("- RX: %d of %d received, timeouts: %d\n", num_bytes_read, STRING_SIZE, num_timeouts);fflush(stdout);
		}
		else if ( y < 0 ) // error
		{
			printf("*** ERROR: Read Error!\n");fflush(stdout);
			pthread_exit(NULL);
		}

		// scan for non-alphabet characters in received string
		for (int x=0; x < y; x++)
		{
			if ( (recv_string[num_bytes_read + x] < 'A') || (recv_string[num_bytes_read + x]> 'Z') )
			{
				printf("\n- RX ERROR: '%c' found in read return.  Byte %d of the %d bytes read does not fit between 'A' & 'Z'!\n", recv_string[num_bytes_read + x], x, y);
			}
		}

		num_bytes_read += y;
		DEBUG_PRINT("- RX: %d of %d received, timeouts: %d\n", num_bytes_read, STRING_SIZE, num_timeouts);fflush(stdout);
	}
	
	if (num_timeouts> MAX_TIMEOUTS)
	{
		printf("-- TX: Exceeded timeout allotment (%d)\n", MAX_TIMEOUTS);
	}

	pthread_exit(NULL);
}


int main (int argc, char *argv[])
{
	int ret_val = -1;

	unsigned char c;
	send_string = (unsigned char*) new unsigned char[STRING_SIZE];
	recv_string = (unsigned char*) new unsigned char[STRING_SIZE];

	// random seed
	srand(time(NULL));

	// -- set up signal controls --
	if(signal(SIGINT, SIG_IGN) != SIG_IGN)
	{
		signal(SIGINT, catchControlC);
	}

	if (argc == 2) // app name + serial port
	{
		int num_loops = 0;

		DEBUG_PRINT("starting...\n");fflush(stdout);

		fd = OpenRawSerialPort(argv[1], 115200, CS8, NO_PARITY, 0, 10);
		if (fd < 0)
		{
			printf("*** ERROR: Failed to open serial port: '%s',(%d)\n", strerror(errno), fd);fflush(stdout);
			exit(-1);
		}

		while(1)
		{
			printf("Iteration: %d...", num_loops);fflush(stdout);

			/* setup send string */
// cap alphabet
			c = 'A';
			for (int x = 0; x < STRING_SIZE; x++)
			{
				send_string[x] = c++;
				if (c == '[') // 1 step past 'Z'
				{
					c = 'A';
				}
			}
	
			/* clear recv string */
			// fill with  characters
			memset(recv_string, ' ', STRING_SIZE);

	        /* create both threads - receiver first since its the consumer */
			if ( pthread_create(&rx_thread, NULL, rx, (void *)recv_string) != 0 )
			{
				exit(-1);
			}
			if ( pthread_create(&tx_thread, NULL, tx, (void *)send_string) != 0 )
			{
				exit(-1);
			}

			/* wait for threads to complete */
			pthread_join(tx_thread, NULL);
			pthread_join(rx_thread, NULL);
	
			printf("done, cross-checking...");fflush(stdout);
			
			int num_errors = 0, offset = 0;

			for (unsigned int x = 0; x < STRING_SIZE; x++)
			{
				if ( send_string[x] != recv_string[x] )
				{
					if (num_errors == 0)
					{
						printf("\n\nIndex:\tTX:\tRX:\n");fflush(stdout);
					}
					printf("%04d\t'%c'[%02x]\t'%c'[%02x]\n", x, send_string[x], send_string[x], recv_string[x], recv_string[x]);fflush(stdout);
					num_errors++;
				}
			}

			if (num_errors == 0)
			{
				printf("done, MATCHED!");
			}
			else
			{
				printf("\n\t*** %d Errors detected @ iteration %d! ***\n", num_errors, num_loops);
			}

			printf("\r");
			usleep(10);
			num_loops++;
		}
	}
	else // show usage
	{
		printf("Error: Usage: '%s ttySx'\n", argv[0]);
	}

	return(ret_val);
}

<<<<<<<<<<< end: test code>>>>>>>>>>>>>

_________________________________________________________________
Your smile counts. The more smiles you share, the more we donate.  Join in.
www.windowslive.com/smile?ocid=TXT_TAGLM_Wave2_oprsmilewlhmtagline
From ralf@linux-mips.org Wed Dec  5 18:22:32 2007
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 18:22:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21412 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030716AbXLESWc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 18:22:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB5IL7pD011316;
	Wed, 5 Dec 2007 18:21:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB5IL6hH011315;
	Wed, 5 Dec 2007 18:21:06 GMT
Date:	Wed, 5 Dec 2007 18:21:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] Alchemy: fix IRQ bases
Message-ID: <20071205182106.GB10697@linux-mips.org>
References: <200712051908.26703.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712051908.26703.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 05, 2007 at 07:08:26PM +0300, Sergei Shtylyov wrote:

> Do what the commits commits f3e8d1da389fe2e514e31f6e93c690c8e1243849 and
> 9d360ab4a7568a8d177280f651a8a772ae52b9b9 failed to achieve -- actually
> convert the Alchemy code to irq_cpu.

Applied, thanks.

  Ralf
